#include <sys/types.h>

#include "user/user.h"
#include <C/stdlib.h>
#include <C/string.h>

#include <zig/test.h>

// テスト用の大きな型
typedef struct {
    int a;
    double b;
    char c;
} BigStruct;

int main() {
    // 大きな型のポインタをmallocで確保
    BigStruct* ptr = (BigStruct*)malloc(sizeof(BigStruct));

    if (ptr == NULL) {
        printf("メモリの確保に失敗しました。\n");
        return 1;
    }

    // アライメント後のポインタを表示
    printf("アライメント後のポインタ: %p\n", (void*)ptr);

    // メモリ領域を特定の値で初期化（ここでは0で初期化）
    memset(ptr, 0, sizeof(BigStruct));

    // メモリの解放
    free(ptr);

    shutdown();

    return 0;
}
