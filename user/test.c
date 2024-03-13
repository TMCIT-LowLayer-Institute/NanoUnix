#include <sys/types.h>

#include "user/user.h"
#include <C/stdlib.h>

#include "../zig/test.h"

int main() {
    int n = 5; // 配列のサイズ
    int *arr = NULL; // 整数ポインタの初期化

    // 動的にメモリを割り当てる
    arr = (int *)malloc(n * sizeof(int));
    if (arr == NULL) {
        printf("メモリの割り当てに失敗しました\n");
        return 1; // エラー終了
    }

    // 配列の要素に値を代入
    for (int i = 0; i < n; i++) {
        arr[i] = i * 2; // 偶数を代入
    }

    // 配列の要素を出力
    printf("配列の要素: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");

    // 割り当てられたメモリを解放
    free(arr);
    arr = NULL; // 安全のため、ポインタをNULLに設定
	
    int a = add(3, 4);
    printf("%d", a);

    return 0;
}
