#include <kern/types.h>

#include <sys/stdint.h>
#include <sys/queue.h>

#include <C/string.h>

#define ALIGN		16
#define BLOCK		4096
#define HEADER_SIZE	(sizeof(struct block_meta))

struct block_meta {
	size_t size;
	int free;
	TAILQ_ENTRY(block_meta) queue;
};
TAILQ_HEAD(free_list_head, block_meta);
static struct free_list_head free_list = TAILQ_HEAD_INITIALIZER(free_list);

extern void *sbrk(intptr_t increment);

static struct block_meta *
find_free_block(size_t size)
{
	struct block_meta *block;

	TAILQ_FOREACH(block, &free_list, queue) {
		if (block->size >= size)
			return block;
	}
	return NULL;
}

static struct block_meta *
request_space(size_t size)
{
	struct block_meta *block;
	void *request;
	size_t total_size = size + HEADER_SIZE;

	request = sbrk(total_size);
	if (request == (void *)-1)
		return NULL;

	block = (struct block_meta *)request;
	block->size = size;
	block->free = 0;
	return block;
}

void *
malloc(size_t size)
{
	struct block_meta *block;

	if (size == 0)
		return NULL;

	size = ALIGN * ((size + ALIGN - 1) / ALIGN);

	if ((block = find_free_block(size)) != NULL) {
		TAILQ_REMOVE(&free_list, block, queue);
		block->free = 0;

		if (block->size >= size + HEADER_SIZE + ALIGN) {
			struct block_meta *new_block = (struct block_meta *)((char *)block + HEADER_SIZE + size);
			new_block->size = block->size - size - HEADER_SIZE;
			new_block->free = 1;
			TAILQ_INSERT_TAIL(&free_list, new_block, queue);

			block->size = size;
		}
	} else {
		block = request_space(size);
		if (block == NULL)
			return NULL;
	}

	return (void *)(block + 1);
}

void
free(void *ptr)
{
	struct block_meta *block, *neighbor;

	if (ptr == NULL)
		return;

	block = ((struct block_meta *)ptr) - 1;
	block->free = 1;

	/* Merge with previous block if it's free */
	neighbor = TAILQ_PREV(block, free_list_head, queue);
	if (neighbor != NULL && neighbor->free && (char *)neighbor + neighbor->size + HEADER_SIZE == (char *)block) {
		TAILQ_REMOVE(&free_list, neighbor, queue);
		neighbor->size += block->size + HEADER_SIZE;
		block = neighbor;
	}

	/* Merge with next block if it's free */
	neighbor = TAILQ_NEXT(block, queue);
	if (neighbor != NULL && neighbor->free && (char *)block + block->size + HEADER_SIZE == (char *)neighbor) {
		TAILQ_REMOVE(&free_list, neighbor, queue);
		block->size += neighbor->size + HEADER_SIZE;
	}
	TAILQ_INSERT_TAIL(&free_list, block, queue);
}

void *
realloc(void *ptr, size_t size)
{
	struct block_meta *block;
	void *new_ptr, *p;

	if (ptr == NULL) {
		if ((p = malloc(size)) == NULL) {
			return NULL;
		}
		return p;
	}

	if (size == 0) {
		free(ptr);
		return NULL;
	}
	block = ((struct block_meta *)ptr) - 1;
	if (block->size >= size)
		return ptr;

	if ((new_ptr = malloc(size)) == NULL) {
		return NULL;
	}

	memcpy(new_ptr, ptr, block->size);
	free(ptr);
	return new_ptr;
}
