#include "program.h"

int s261744_helper(int n, int m) {
	int r;
	while (m > 0) {
		r = n % m;
		n = m;
		m = r;
	}
	return n;
}

void s261744_podprogram() {
	printf("Radosław Koczan Dubieniecki nr indeksu: 261744\n");
	printf("Program wczytuje dwie liczby całkowite i drukuje ich największy wspólny dzielnik\n");
	int x, y;
	printf("Podaj liczbę x: ");
	scanf("%d", &x);
	printf("Podaj liczbę y: ");
	scanf("%d", &y);
	printf("Największy wspólny dzielnik liczb %d i %d wynosi: %d\n", x, y, s261744_helper(x, y));
}
