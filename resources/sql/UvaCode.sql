INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (1, 100, 'The 3n + 1 problem', '100 - The 3n + 1 problem', 'https://onlinejudge.org/external/1/p100.pdf', 1, '//uva100
#include <bits/stdc++.h>

using namespace std;

int len(int i) {
    int leng=1;
    while(i!=1){
    if (i & 1)
        i = i * 3 + 1;
    else
        i /= 2;
    leng++;
    }
    return leng;
}

int main() {
    int a, b;
    while (cin >> a >> b) {
        int ans = 0;
        cout << a << \" \" << b << \" \";
        for (int i = min(a, b); i <= max(a, b); i++) {
            ans = max(len(i), ans);
        }
        cout << ans << endl;
    }
    return 0;
}', '1 10
100 200
201 210
900 1000', '1 10 20
100 200 125
201 210 89
900 1000 174', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (2, 118, 'Mutant Flatworld Explorers', '118 - Mutant Flatworld Explorers', 'https://onlinejudge.org/external/1/p118.pdf', 1, '//uva118
#include <iostream>

using namespace std;

int main() {
  bool scent[55][55] = {0};
  int bound_x, bound_y;
  int init_x, init_y;
  char init_ori;
  int curr_x, curr_y, curr_ori = 0;
  bool if_lost = false;
  string ins;

  cin >> bound_x >> bound_y;
  while (cin >> init_x >> init_y >> init_ori) {
    cin >> ins;
    curr_x = init_x;
    curr_y = init_y;
    if_lost = false;
    switch (init_ori) {
    case \'N\':
      curr_ori = 0;
      break;
    case \'E\':
      curr_ori = 1;
      break;
    case \'S\':
      curr_ori = 2;
      break;
    case \'W\':
      curr_ori = 3;
      break;
    }

    for (auto i : ins) {
      int next_x = curr_x, next_y = curr_y;

      if (i == \'L\') {
        curr_ori = (curr_ori + 3) % 4;
      } else if (i == \'R\') {
        curr_ori = (curr_ori + 1) % 4;
      } else if (i == \'F\') {
        switch (curr_ori) {
        case 0:
          next_y = curr_y + 1;
          break;
        case 1:
          next_x = curr_x + 1;
          break;
        case 2:
          next_y = curr_y - 1;
          break;
        case 3:
          next_x = curr_x - 1;
          break;
        }
        if (next_x < 0 || next_x > bound_x || next_y < 0 || next_y > bound_y) {
          if (scent[curr_x][curr_y])
            continue;
          else {
            if_lost = true;
            scent[curr_x][curr_y] = true;
            break;
          }
        }
        curr_x = next_x;
        curr_y = next_y;
      }
    }
    cout << curr_x << \" \" << curr_y << \" \";
    switch (curr_ori) {
    case 0:
      cout << \"N\";
      break;
    case 1:
      cout << \"E\";
      break;
    case 2:
      cout << \"S\";
      break;
    case 3:
      cout << \"W\";
      break;
    }
    if (if_lost)
      cout << \" LOST\";
    cout << endl;
  }
  return 0;
}', '5 3
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL', '1 1 E
3 3 N LOST
2 3 S', '20 20
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL
1 5 S
RLRLRFF
11 7 E
LFLRFFRLRFFLFRRFRRLLLFLRLFLRLLRRFL
11 4 E
LRRLLRFRFRRLFFRRLFFRLRRLLLRFFRFRLRRF
6 10 E
FFFRFFRFLLRLFFFFLRRRLLFL
2 2 E
RRLLRRLFFFLFLRLRFFLFLRLFLFFLLLFFRFRRLFL
3 9 S
LFLRLFFRFFLFRRRRFFLRLLLRR
10 14 N
RRLLRFFFFFFFLRFLRRRLRFL
11 19 S
RFLRRRRR
1 11 E
LRRFLFFLFFRRFLRFLLLLR
8 3 N
FFLLFFR
0 1 S
RRRFRFLLFLRLFFLR
19 4 N
FRRFLRFLRFLLRLRLLRRLFFRRLLFL
2 1 N
RLFRLLFRRRFFLLLLLLRLFLFL
16 5 S
FLFRLLLLLFLFFF
16 17 N
RRRLLLLLLFLRRFLFLLFFLRFFLLRLRLFLRFRLLRFRRF
1 16 N
RRLRLFRLRLF
8 15 W
FLRFRRFFFFRFFLLFLLLFRRFFRLFFRRRLRFLRFRFLFLFL
1 14 N
RLRFRRRLRFRFRLRRRRRFLRL
6 0 W
RLFRRFLRLFFFFRR
3 4 E
RFFLFFRLFLLRRFLLLRFRLLFFL
12 5 W
RLRLFRFFRRRFFRRLFLLFFFRRRRRFL
16 13 N
FFFRRRRFRRFFLRLFRRRFLFRLLLLRFRRLLRRRRRLLFFR
17 8 S
RLFLLRRLRLRLFFRLFLFFFRLRFLLLFFLRFRRLLLFRL
7 14 E
LLRFRRFRRRFFFR
0 16 E
FRLFLFLLFFLFRRFFRFFFLRRRLLFRRFFRRLRFFLLFL
4 14 S
FLRLRLRFLFFRFFLLLFFRFLRLLFFLL
11 14 N
RLFFLLRRLRLFLFRRLFLRFFFLFLLLFFL
3 17 E
FRRLFLFFRRRRLRLFFLFRRRLRF', '1 1 E
3 3 N
2 4 S
0 5 W LOST
14 12 W
10 7 W
13 8 N
2 0 S LOST
6 14 W
17 14 S
10 19 W
3 10 W
8 3 W
0 1 W LOST
19 5 W
0 1 S
18 7 N
16 16 W
3 16 E
7 11 N
3 14 E
6 4 S
6 0 E
8 5 S
17 18 E
20 10 E LOST
10 14 S
1 18 E
4 9 N
4 14 S
5 17 S', '20 20
1 1 E
RFRFRFRF
3 2 N
FRRFLLFFRRFLL
0 3 W
LLFFFLFLFL
14 11 E
FFFFRFRFLFLRLFLLLRRRFLRLFLRRFRLRLLLR
11 11 S
FLFFFFFLFFFLLRRLFFFFFFRRRL
19 7 S
RLFLRLRL
4 1 N
FRFLLRFFLFLLRLFFLRFRFRLRFRFRLFFRLFLR
13 7 E
FLFFRLLFRRFFRRLLRRRRFFFFFFRLFRRRRFLFRFLRRF
13 8 S
FFLRFLFRFLLFRFLLFRFRFFRFRFRFRLFRLLFLR
7 4 N
FLRRRLFLRRFFRLFFFRRLLFFFRRFLLRRLRFFLLR
4 10 W
LLRFFFRLL
13 17 S
LFFRLRRLFFRFFFL
5 15 E
LFFRRLLRLRRLRLLLFLLRLRLRLFLLLFFFFRLLL
10 9 E
FLFLRLRLFLRRRFRRRF
10 11 W
LRLRFFLFRFLLLRFLRFLRRFRFRFLFRFLRFFF
18 17 E
RLRFFRRFFRRLFFFFRRFLRRLFLR
17 16 S
FLLRRLRFLFLRLFLRRFFRRFRRFRLLRLFRRLLLLRRFFRFR
19 13 S
RLRLFLFLRFLLLFLFRRRRLFLFL
18 14 W
FRLFRLFRLRLLRRRFFFLLRF
8 0 S
FFLLFLRRFLRLFFRFLLRRLFLRLL
14 3 N
FFRLFFRLFFRFRRFLLRL
4 17 N
RLLLFLLRLFRLLFFFLFLFLLRRFRFFLR
17 6 S
FLRFFFLFLLRLRFRFLLFLRLRRRRRRLRLFL
1 11 N
LLRFLRFL
1 9 E
RLFFLRFFRFFLRRR
14 16 W
RFRFRFRRRRLFRF
8 17 S
FFRLFLLFLFFRLFLFRFFRLLRFRRFFFRLRLF
16 12 E
FRRFFLFFLRLFRLRFRLRRRLRFLFLLLFRLFRFFR
9 7 E
RLRFLRRRRLLFLRLFFRFFFFFFLLR
5 7 E
FFRRLLLRLRLLFLLFRFRRFRL
1 13 W
LFLRLFLFFRLLRFLRLFFRRFFLLRLFLFFRRFLFFLFRRL', '1 1 E
3 3 N
2 4 S
20 10 N
10 13 E
19 6 E
6 7 N
20 9 E LOST
14 7 W
8 0 S LOST
4 7 E
12 15 S
5 13 N
11 11 N
7 14 N
20 17 E LOST
20 18 E LOST
20 12 E LOST
18 15 N
10 4 S
14 9 E
3 14 S
17 3 S
0 11 W LOST
5 7 N
16 15 S
6 14 E
19 8 W
2 4 S
7 7 N
0 14 W LOST');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (3, 272, 'TeX Quotes', '272 - TeX Quotes', 'https://onlinejudge.org/external/2/p272.pdf', 1, '//uva272
#include <cstdio>
#include <iostream>

using namespace std;

int main() {
	int flag = 1;
	char ch;

	while(scanf(\"%c\", &ch) != EOF) {
		if(ch == \'\"\') {
			if(flag)
				cout << \"``\";
			else
				cout << \"\'\'\";
			flag = 1 - flag;
		}
		else
			cout << ch;
	}
	return 0;
}', '測資過長', '測資過長', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (4, 299, 'Train Swapping', '299 - Train Swapping', 'https://onlinejudge.org/external/2/p299.pdf', 1, '//uva299
#include <stdio.h>

int main()
{
	int n, l, i, k, tr[100], t, count;
	scanf(\"%d\", &n);
	while(n--) {
		for(i = 0; i < 100; i++)
			tr[i] = 0;
		count = 0;
		scanf(\"%d\", &l);
		for(i = 0; i < l; i++)
			scanf(\"%d\", &tr[i]);
		for(i = 0; i < l - 1; i++)
			for(k = 0; k < l - 1; k++)
				if(tr[k]>tr[k+1])
				{
					t = tr[k];
					tr[k] = tr[k + 1];
					tr[k + 1] = t;
					count++;
				}
		printf(\"Optimal train swapping takes %d swaps.\\n\",count);
	}

	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '25
3
1 3 2
4
4 3 2 1
2
2 1
2
1 2
1
1
5
1 5 2 3 4
5
1 2 3 4 5
5
5 2 3 4 1
6
6 5 4 3 2 1
6
1 3 2 4 5 6
7
6 2 5 3 1 7 4
12
6 3 9 4 8 7 2 10 11 12 5 1
15
6 15 9 5 1 12 13 14 4 10 3 8 7 11 2
19
10 17 12 8 1 2 16 6 14 11 15 9 7 4 19 5 3 18 13
48
31 37 40 27 46 22 7 10 23 5 33 39 17 32 36 26 4 12 19 20 16 42 18 41 30 43 28 47 35 1 2 38 25 48 9 6 45 34 3 44 21 14 8 11 24 13 15 29
42
24 6 22 21 39 40 7 18 30 15 29 11 42 12 34 2 14 27 20 3 19 41 1 25 26 38 5 17 8 28 13 16 35 31 37 36 9 10 4 23 33 32
46
25 14 18 8 38 7 19 45 46 5 43 34 9 36 33 37 12 30 26 42 10 29 11 1 15 3 21 27 6 28 16 32 40 31 13 35 17 44 41 23 24 2 4 22 39 20
47
4 37 34 16 26 23 6 11 5 1 7 32 29 12 14 10 3 36 35 18 2 42 21 31 20 33 40 30 44 43 38 46 45 8 28 13 27 41 39 19 24 47 15 25 22 9 17
32
14 12 15 26 1 21 16 8 9 30 24 23 10 7 18 27 32 6 13 11 17 29 31 4 22 2 19 25 3 5 28 20
33
26 33 3 18 30 13 32 12 27 14 8 11 17 1 31 4 6 21 10 20 22 19 7 25 9 28 16 2 5 29 23 24 15
32
24 16 23 2 12 15 9 6 4 20 13 26 11 29 18 22 21 7 25 19 8 3 14 5 32 17 28 30 31 1 27 10
33
3 8 23 33 29 30 13 19 12 31 17 2 24 9 27 10 21 14 26 25 22 16 18 6 4 28 15 20 11 5 7 1 32
22
15 19 17 12 5 4 16 13 10 8 18 6 14 20 22 9 3 11 7 21 1 2
50
14 8 41 50 7 20 16 31 49 29 37 15 18 21 19 10 44 23 42 26 38 46 32 17 3 5 47 40 39 34 35 24 43 1 33 4 48 27 2 12 28 45 22 36 6 30 25 9 13 11
49
35 22 3 2 31 10 8 27 38 43 28 11 49 21 45 19 9 14 15 13 36 4 34 37 47 46 26 41 16 18 7 23 25 17 32 44 24 20 40 1 42 6 33 30 29 5 39 12 48', 'Optimal train swapping takes 1 swaps.
Optimal train swapping takes 6 swaps.
Optimal train swapping takes 1 swaps.
Optimal train swapping takes 0 swaps.
Optimal train swapping takes 0 swaps.
Optimal train swapping takes 3 swaps.
Optimal train swapping takes 0 swaps.
Optimal train swapping takes 7 swaps.
Optimal train swapping takes 15 swaps.
Optimal train swapping takes 1 swaps.
Optimal train swapping takes 11 swaps.
Optimal train swapping takes 30 swaps.
Optimal train swapping takes 61 swaps.
Optimal train swapping takes 86 swaps.
Optimal train swapping takes 614 swaps.
Optimal train swapping takes 424 swaps.
Optimal train swapping takes 527 swaps.
Optimal train swapping takes 444 swaps.
Optimal train swapping takes 240 swaps.
Optimal train swapping takes 281 swaps.
Optimal train swapping takes 221 swaps.
Optimal train swapping takes 304 swaps.
Optimal train swapping takes 139 swaps.
Optimal train swapping takes 654 swaps.
Optimal train swapping takes 542 swaps.', '25
4
2 1 4 3
3
2 3 1
7
4 1 6 2 7 5 3
3
1 2 3
8
2 7 6 3 4 1 5 8
7
7 6 5 4 3 2 1
41
27 28 8 16 35 18 30 10 37 21 12 39 17 24 20 13 11 25 23 22 5 31 1 6 4 7 32 26 34 29 40 2 14 33 19 38 9 15 36 3 41
50
50 36 6 23 10 3 43 48 29 31 25 39 11 15 21 1 5 18 2 22 26 28 7 44 27 8 38 19 17 35 14 37 46 30 47 16 40 12 32 34 4 49 42 13 20 33 41 9 24 45
30
3 5 9 30 15 28 20 6 10 11 14 2 22 16 18 19 24 4 21 25 7 17 1 29 23 27 12 8 13 26
24
8 14 18 21 22 12 19 2 4 17 13 23 5 16 6 20 11 7 15 1 24 10 9 3
28
8 4 7 23 14 1 6 13 22 19 28 26 10 27 12 5 24 11 17 21 20 9 18 15 3 2 25 16
34
15 20 29 5 1 12 19 8 4 10 23 31 26 33 32 18 25 14 34 6 24 30 27 16 21 22 28 11 9 17 2 3 7 13
36
18 15 21 12 25 2 6 32 19 8 30 28 5 7 22 31 10 13 3 29 20 34 33 4 23 9 17 26 27 24 1 16 14 36 35 11
42
31 26 42 21 7 11 36 5 22 19 2 39 10 37 40 17 30 18 15 35 13 25 3 33 6 12 23 24 4 32 38 29 41 1 16 27 20 28 34 9 8 14
10
10 9 4 2 1 7 5 8 6 3
15
13 15 10 5 7 14 9 2 8 4 3 11 12 6 1
37
37 35 32 22 25 2 14 5 31 12 21 16 34 11 24 6 7 20 29 15 13 4 26 23 19 3 8 1 17 36 9 18 28 10 30 33 27
9
9 2 1 6 8 3 5 7 4
21
16 15 13 19 21 8 6 18 4 14 9 17 12 11 20 7 10 5 1 3 2
19
5 19 11 8 18 7 10 12 15 3 14 4 9 13 2 6 16 17 1
12
7 8 4 1 10 2 9 6 12 5 11 3
23
5 9 22 4 19 23 15 6 20 1 2 3 16 8 18 11 13 14 10 17 21 7 12
18
10 1 12 9 14 7 8 5 6 11 18 17 2 16 13 15 3 4
25
24 14 19 8 6 20 13 11 2 25 4 10 1 23 18 16 12 22 17 3 5 15 7 9 21
50
50 49 48 47 46 45 44 43 42 41 40 39 38 37 36 35 34 33 32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1', 'Optimal train swapping takes 2 swaps.
Optimal train swapping takes 2 swaps.
Optimal train swapping takes 9 swaps.
Optimal train swapping takes 0 swaps.
Optimal train swapping takes 12 swaps.
Optimal train swapping takes 21 swaps.
Optimal train swapping takes 400 swaps.
Optimal train swapping takes 550 swaps.
Optimal train swapping takes 180 swaps.
Optimal train swapping takes 161 swaps.
Optimal train swapping takes 177 swaps.
Optimal train swapping takes 298 swaps.
Optimal train swapping takes 282 swaps.
Optimal train swapping takes 460 swaps.
Optimal train swapping takes 28 swaps.
Optimal train swapping takes 71 swaps.
Optimal train swapping takes 355 swaps.
Optimal train swapping takes 18 swaps.
Optimal train swapping takes 152 swaps.
Optimal train swapping takes 95 swaps.
Optimal train swapping takes 30 swaps.
Optimal train swapping takes 120 swaps.
Optimal train swapping takes 74 swaps.
Optimal train swapping takes 164 swaps.
Optimal train swapping takes 1225 swaps.');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (5, 490, 'Rotating Sentences', '490 - Rotating Sentences', 'https://onlinejudge.org/external/4/p490.pdf', 1, '//uva490
#include <iostream>
#include <string>
using namespace std;
int main(){
    string a[101];
    int n=0;
    int max=0;
    while (getline(cin,a[n]) && a[n]!=\"\"){
        if(a[n].length()>max){
            max = a[n].length();
        }
        n++;
    }
    for (int i=0;i<max;i++){
        for (int j=n-1;j>=0;j--){
            if (a[j].length()>i){
                cout<<a[j][i];
            }
            else{
                cout<<\' \';
            }
        }
        cout<<endl;
    }
}', 'Rene Decartes once said,
\"I think, therefore I am.\"', '\"R
Ie
 n
te
h 
iD
ne
kc
,a
 r
tt
he
es
r 
eo
fn
oc
re
e 
 s
Ia
 i
ad
m,
. 
\"', 'Experience is the best teacher.
William Hazlitt once said,
\"The more we do, the more we can do.\"
Better to sail slowly than not to sail at all.
Life is not fair; get used to it.', 'LB\"WE
ieTix
fthlp
etele
 e ir
irmai
s ome
 tr n
noeHc
o  ae
tswz 
 aeli
fi is
aldt 
i ott
rs, h
;l oe
 otn 
gwhcb
eleee
ty  s
  mst
utoa 
shrit
eaede
dn ,a
  w c
tne h
oo  e
 tc r
i a .
ttn  
.o   
  d  
 so  
 a.  
 i\"  
 l   
     
 a   
 t   
     
 a   
 l   
 l   
 .', 'Knowledge is power.
Mischief all comes from much opening of the mouth.
Time flies.
A friend in need is a friend indeed.
Napoleon once said,
\"Victory belongs to the most persevering.\"', '\"NATMK
Va iin
ipfmso
corecw
tli hl
oeefie
ronled
yndifg
   e e
boisa 
enn.li
lc  ls
oen   
n e cp
gse oo
sad mw
 i  ee
tdi sr
o,s  .
    f 
t a r 
h   o 
e f m 
  r   
m i m 
o e u 
s n c 
t d h 
      
p i o 
e n p 
r d e 
s e n 
e e i 
v d n 
e . g 
r     
i   o 
n   f 
g     
.   t 
\"   h 
    e 
      
    m 
    o 
    u 
    t 
    h 
    .');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (6, 948, 'Fibonaccimal Base', '948 - Fibonaccimal Base', 'https://onlinejudge.org/external/9/p948.pdf', 1, '//uva948
#include<iostream>
using namespace std;

int main() {
	int f[40] = {0, 1};
	for(int k = 2; k < 40; k++)
	  f[k] = f[k - 1] + f[k - 2];
	int n;
	cin >> n;
	while(n--) {
		int m;
		cin >> m;
		cout << m << \" = \";
		bool preone = false;
		for(int k = 39; k >= 2; k--) {
			if(m >= f[k]) {
				cout << \"1\";
				m -= f[k];
				preone = true;
			}
			else if(preone) {
				cout << \"0\";
			}
		}
		cout << \" (fib)\" << endl;
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '18
1
2
3
4
5
6
7
8
9
10
13
17
100
1234
432134
45678934
98765432
99999999', '1 = 1 (fib)
2 = 10 (fib)
3 = 100 (fib)
4 = 101 (fib)
5 = 1000 (fib)
6 = 1001 (fib)
7 = 1010 (fib)
8 = 10000 (fib)
9 = 10001 (fib)
10 = 10010 (fib)
13 = 100000 (fib)
17 = 100101 (fib)
100 = 1000010100 (fib)
1234 = 100100000100001 (fib)
432134 = 100101001010100100100100101 (fib)
45678934 = 1000100010000010001010000001001010100 (fib)
98765432 = 10101000101010100000001010000000100100 (fib)
99999999 = 10101001010100001010000010101010000010 (fib)', '24
1
2
3
4
5
6
7
8
9
10
17
50
60
70
123
3456
12992
823479
349033
12345678
99999999
99999998
23231233
98765432', '1 = 1 (fib)
2 = 10 (fib)
3 = 100 (fib)
4 = 101 (fib)
5 = 1000 (fib)
6 = 1001 (fib)
7 = 1010 (fib)
8 = 10000 (fib)
9 = 10001 (fib)
10 = 10010 (fib)
17 = 100101 (fib)
50 = 10100100 (fib)
60 = 100001000 (fib)
70 = 100100010 (fib)
123 = 1010000000 (fib)
3456 = 10010100001010000 (fib)
12992 = 10001001000100100101 (fib)
823479 = 1010101001001010010010000000 (fib)
349033 = 100001000001010101010000010 (fib)
12345678 = 1001010000101000100000000000000001 (fib)
99999999 = 10101001010100001010000010101010000010 (fib)
99999998 = 10101001010100001010000010101010000001 (fib)
23231233 = 10101000100100101001010010001000001 (fib)
98765432 = 10101000101010100000001010000000100100 (fib)');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (7, 10008, 'What`s Cryptanalysis?', '10008 - What`s Cryptanalysis?', 'https://onlinejudge.org/external/100/p10008.pdf', 1, '//uva10008
#include <iostream>
#include <cctype>
#include <algorithm>
#include <cstring>
#include <cstdio>

#define len 5000

using namespace std;

int main() {
	int n, length, i, j, t;
	char msg[len];

	char alp[28]=\"ABCDEFGHIJKLMNOPQRSTUVWXYZ\";
	int num[28] = {};

	cin >> n;
	cin.ignore();

	for(i = 0; i < n ; i++) {
		cin.getline(msg, len);
		length = strlen(msg);

		for(j = 0; j < length; j++)
			if(isalpha(msg[j]))
				num[toupper(msg[j])-\'A\']++;
	}

	for(i = 0; i < 26; i++) {
		for(j = 0; j < 26; j++) {
			if(num[j] < num[j+1]) {
				t = num[j];
				num[j] = num[j+1];
				num[j+1] = t;

				t = alp[j];
				alp[j] = alp[j+1];
				alp[j+1] = t;
			}
		}
	}
	for(j = 0; j < 26; j++)
		if(num[j])
			printf(\"%c %d\\n\", alp[j], num[j]);

	return 0;
}', '31
How to submit your source codes 
You can do it by using one of two ways: email and Submit-o-matic 
Submitting via Email (NOT MORE AVAILABLE) 
If you already are a member (a registered user) and thus you have your own User ID
you can send by E-mail your C/C++/Java/Pascal sources, solving any of the problems available in our database,
to judge@uva.es, in order to test whether they reach a correct answer or not. 
For example, under Unix, and being p.c your solution for a problem in our Problem Set: 
mail judge@uva.es < p.c 
Your program must contain a line (at any location) with a @JUDGE_ID field.
Usually, this line is placed inside a comment. For example, using C languaje (comments in C are placed inside /* and */) : 
/* @JUDGE_ID: 1000AA 100 C \"Dynamic Programming\" */ 
The first field after the @JUDGE_ID: is your User ID (1000AA in the example).
It is followed by the program number (100 in the example), and, optionally, by the languaje used (it may be C, C++, Java or Pascal).
Don\'t worry about upper or lower cases. If you don\'t specify the languaje, the judge will try to autodetect it. 
If you have used any special algorithm or method, you can optionally include it between quotes (Dynamic Programming in the example):
be careful in typing, and do not use more than 63 characters: it will appear in some Web Ranklist\'s. 

Please: don\'t place the problem title in the algorithm field (this will be redundant in the ranklists!).
Also, please remember to be polite with the other users: don\'t write disgusting comments, please
NOTE: algorithms have been partially disabled because of some abusing people.
If your mail system adds extra lines at the end of your letter (as Hotmail or Yahoo do), you\'ll get a compile error.
A way to skip this problem is to place a \"@END_OF_SOURCE_CODE\" or a \"@end_of_source_code\" message in a single line just after the last line of source code.
Do not place any source code in this line!. 
If your mail system adds extra lines in the first body lines of your letter, you\'ll also get a compile error.
A way to skip this problem is to place a \"@BEGIN_OF_SOURCE_CODE\" or a \"@begin_of_source_code\" message in a single line before the first line of source code.
Do not place any source code in this line!. Submitting via Submit-o-matic 

If submitting via email is not an option, try the Submit-o-matic system. 
Just fill in your user ID, the problem ID and the language the problem is written, and then copy/paste your source-code or upload it from your machine. 
Using Submit-o-matic, you don\'t have to include any @BEGIN_OF_SOURCE_CODE, @END_OF_SOURCE_CODE or @JUDGE_ID as everything is handled by the system. 
As an example you can see the solution for problem 100 in C, Java and Pascal: LLLLLLLLll     ccccCCCC bbbbbbbbbb GGGGGGGGggg', 'E 241
O 176
A 171
I 156
T 150
S 127
N 124
L 120
R 120
U 94
C 85
D 85
M 74
Y 60
B 55
G 55
H 55
P 55
F 37
W 20
V 16
J 15
X 9
K 4
Q 1', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (8, 10019, 'Funny Encryption Method', '10019 - Funny Encryption Method', 'https://onlinejudge.org/external/100/p10019.pdf', 1, '//uva10019
#include<iostream>

using namespace std;

int main(){
   int N;
   cin >> N;
   while(N--){
      int m;
	  cin >> m;
	  
      int b1 = 0, b2 = 0;
      for(int v = m; v; v /= 2) b1 += v % 2;
      for(; m; m /= 10)
         for(int v = m % 10; v; v /= 2) b2 += v % 2;
      cout << b1 << \" \" << b2 << endl;
   }
   return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '1000
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
248
249
250
251
252
253
254
255
256
257
258
259
260
261
262
263
264
265
266
267
268
269
270
271
272
273
274
275
276
277
278
279
280
281
282
283
284
285
286
287
288
289
290
291
292
293
294
295
296
297
298
299
300
301
302
303
304
305
306
307
308
309
310
311
312
313
314
315
316
317
318
319
320
321
322
323
324
325
326
327
328
329
330
331
332
333
334
335
336
337
338
339
340
341
342
343
344
345
346
347
348
349
350
351
352
353
354
355
356
357
358
359
360
361
362
363
364
365
366
367
368
369
370
371
372
373
374
375
376
377
378
379
380
381
382
383
384
385
386
387
388
389
390
391
392
393
394
395
396
397
398
399
400
401
402
403
404
405
406
407
408
409
410
411
412
413
414
415
416
417
418
419
420
421
422
423
424
425
426
427
428
429
430
431
432
433
434
435
436
437
438
439
440
441
442
443
444
445
446
447
448
449
450
451
452
453
454
455
456
457
458
459
460
461
462
463
464
465
466
467
468
469
470
471
472
473
474
475
476
477
478
479
480
481
482
483
484
485
486
487
488
489
490
491
492
493
494
495
496
497
498
499
500
501
502
503
504
505
506
507
508
509
510
511
512
513
514
515
516
517
518
519
520
521
522
523
524
525
526
527
528
529
530
531
532
533
534
535
536
537
538
539
540
541
542
543
544
545
546
547
548
549
550
551
552
553
554
555
556
557
558
559
560
561
562
563
564
565
566
567
568
569
570
571
572
573
574
575
576
577
578
579
580
581
582
583
584
585
586
587
588
589
590
591
592
593
594
595
596
597
598
599
600
601
602
603
604
605
606
607
608
609
610
611
612
613
614
615
616
617
618
619
620
621
622
623
624
625
626
627
628
629
630
631
632
633
634
635
636
637
638
639
640
641
642
643
644
645
646
647
648
649
650
651
652
653
654
655
656
657
658
659
660
661
662
663
664
665
666
667
668
669
670
671
672
673
674
675
676
677
678
679
680
681
682
683
684
685
686
687
688
689
690
691
692
693
694
695
696
697
698
699
700
701
702
703
704
705
706
707
708
709
710
711
712
713
714
715
716
717
718
719
720
721
722
723
724
725
726
727
728
729
730
731
732
733
734
735
736
737
738
739
740
741
742
743
744
745
746
747
748
749
750
751
752
753
754
755
756
757
758
759
760
761
762
763
764
765
766
767
768
769
770
771
772
773
774
775
776
777
778
779
780
781
782
783
784
785
786
787
788
789
790
791
792
793
794
795
796
797
798
799
800
801
802
803
804
805
806
807
808
809
810
811
812
813
814
815
816
817
818
819
820
821
822
823
824
825
826
827
828
829
830
831
832
833
834
835
836
837
838
839
840
841
842
843
844
845
846
847
848
849
850
851
852
853
854
855
856
857
858
859
860
861
862
863
864
865
866
867
868
869
870
871
872
873
874
875
876
877
878
879
880
881
882
883
884
885
886
887
888
889
890
891
892
893
894
895
896
897
898
899
900
901
902
903
904
905
906
907
908
909
910
911
912
913
914
915
916
917
918
919
920
921
922
923
924
925
926
927
928
929
930
931
932
933
934
935
936
937
938
939
940
941
942
943
944
945
946
947
948
949
950
951
952
953
954
955
956
957
958
959
960
961
962
963
964
965
966
967
968
969
970
971
972
973
974
975
976
977
978
979
980
981
982
983
984
985
986
987
988
989
990
991
992
993
994
995
996
997
998
999
1000', '1 1
1 1
2 2
1 1
2 2
2 2
3 3
1 1
2 2
2 1
3 2
2 2
3 3
3 2
4 3
1 3
2 4
2 2
3 3
2 1
3 2
3 2
4 3
2 2
3 3
3 3
4 4
3 2
4 3
4 2
5 3
1 3
2 4
2 3
3 4
2 4
3 5
3 3
4 4
2 1
3 2
3 2
4 3
3 2
4 3
4 3
5 4
2 2
3 3
3 2
4 3
3 3
4 4
4 3
5 4
3 4
4 5
4 3
5 4
4 2
5 3
5 3
6 4
1 3
2 4
2 4
3 5
2 3
3 4
3 3
4 4
2 4
3 5
3 4
4 5
3 5
4 6
4 4
5 5
2 1
3 2
3 2
4 3
3 2
4 3
4 3
5 4
3 2
4 3
4 2
5 3
4 3
5 4
5 3
6 4
2 4
3 5
3 3
4 4
3 1
4 2
4 2
5 3
3 2
4 3
4 3
5 4
4 2
5 3
5 2
6 3
3 3
4 4
4 3
5 4
4 4
5 5
5 3
6 4
4 2
5 3
5 3
6 4
5 3
6 4
6 4
7 5
1 3
2 4
2 3
3 4
2 4
3 5
3 4
4 5
2 5
3 6
3 4
4 5
3 2
4 3
4 3
5 4
2 3
3 4
3 4
4 5
3 3
4 4
4 3
5 4
3 4
4 5
4 4
5 5
4 5
5 6
5 4
6 5
2 3
3 4
3 4
4 5
3 4
4 5
4 5
5 6
3 4
4 5
4 4
5 5
4 5
5 6
5 5
6 6
3 6
4 7
4 5
5 6
4 2
5 3
5 3
6 4
4 3
5 4
5 4
6 5
5 3
6 4
6 3
7 4
2 4
3 5
3 4
4 5
3 5
4 6
4 4
5 5
3 1
4 2
4 2
5 3
4 2
5 3
5 3
6 4
3 2
4 3
4 2
5 3
4 3
5 4
5 3
6 4
4 4
5 5
5 3
6 4
5 2
6 3
6 3
7 4
3 3
4 4
4 4
5 5
4 3
5 4
5 3
6 4
4 4
5 5
5 4
6 5
5 5
6 6
6 4
7 5
4 2
5 3
5 3
6 4
5 3
6 4
6 4
7 5
5 3
6 4
6 3
7 4
6 4
7 5
7 4
8 5
1 5
2 6
2 4
3 5
2 3
3 4
3 4
4 5
2 4
3 5
3 5
4 6
3 4
4 5
4 4
5 5
2 5
3 6
3 5
4 6
3 6
4 7
4 5
5 6
3 2
4 3
4 3
5 4
4 3
5 4
5 4
6 5
2 3
3 4
3 3
4 4
3 4
4 5
4 4
5 5
3 5
4 6
4 4
5 5
4 2
5 3
5 3
6 4
3 3
4 4
4 4
5 5
4 3
5 4
5 3
6 4
4 4
5 5
5 4
6 5
5 5
6 6
6 4
7 5
2 3
3 4
3 4
4 5
3 4
4 5
4 5
5 6
3 4
4 5
4 4
5 5
4 5
5 6
5 5
6 6
3 6
4 7
4 5
5 6
4 3
5 4
5 4
6 5
4 4
5 5
5 5
6 6
5 4
6 5
6 4
7 5
3 5
4 6
4 5
5 6
4 6
5 7
5 5
6 6
4 4
5 5
5 5
6 6
5 5
6 6
6 6
7 7
4 5
5 6
5 5
6 6
5 6
6 7
6 6
7 7
5 7
6 8
6 6
7 7
6 3
7 4
7 4
8 5
2 4
3 5
3 5
4 6
3 4
4 5
4 4
5 5
3 5
4 6
4 5
5 6
4 6
5 7
5 5
6 6
3 1
4 2
4 2
5 3
4 2
5 3
5 3
6 4
4 2
5 3
5 2
6 3
5 3
6 4
6 3
7 4
3 4
4 5
4 3
5 4
4 2
5 3
5 3
6 4
4 3
5 4
5 4
6 5
5 3
6 4
6 3
7 4
4 4
5 5
5 4
6 5
5 5
6 6
6 4
7 5
5 2
6 3
6 3
7 4
6 3
7 4
7 4
8 5
3 3
4 4
4 3
5 4
4 4
5 5
5 4
6 5
4 5
5 6
5 4
6 5
5 3
6 4
6 4
7 5
4 4
5 5
5 5
6 6
5 4
6 5
6 4
7 5
5 5
6 6
6 5
7 6
6 6
7 7
7 5
8 6
4 2
5 3
5 3
6 4
5 3
6 4
6 4
7 5
5 3
6 4
6 3
7 4
6 4
7 5
7 4
8 5
5 5
6 6
6 4
7 5
6 2
7 3
7 3
8 4
6 3
7 4
7 4
8 5
7 3
8 4
8 3
9 4
1 4
2 5
2 4
3 5
2 5
3 6
3 4
4 5
2 3
3 4
3 4
4 5
3 4
4 5
4 5
5 6
2 4
3 5
3 4
4 5
3 5
4 6
4 5
5 6
3 6
4 7
4 5
5 6
4 3
5 4
5 4
6 5
2 4
3 5
3 5
4 6
3 4
4 5
4 4
5 5
3 5
4 6
4 5
5 6
4 6
5 7
5 5
6 6
3 4
4 5
4 5
5 6
4 5
5 6
5 6
6 7
4 5
5 6
5 5
6 6
5 6
6 7
6 6
7 7
2 7
3 8
3 6
4 7
3 3
4 4
4 4
5 5
3 4
4 5
4 5
5 6
4 4
5 5
5 4
6 5
3 5
4 6
4 5
5 6
4 6
5 7
5 5
6 6
4 2
5 3
5 3
6 4
5 3
6 4
6 4
7 5
3 3
4 4
4 3
5 4
4 4
5 5
5 4
6 5
4 5
5 6
5 4
6 5
5 3
6 4
6 4
7 5
4 4
5 5
5 5
6 6
5 4
6 5
6 4
7 5
5 5
6 6
6 5
7 6
6 6
7 7
7 5
8 6
2 3
3 4
3 4
4 5
3 4
4 5
4 5
5 6
3 4
4 5
4 4
5 5
4 5
5 6
5 5
6 6
3 6
4 7
4 5
5 6
4 4
5 5
5 5
6 6
4 5
5 6
5 6
6 7
5 5
6 6
6 5
7 6
3 6
4 7
4 6
5 7
4 7
5 8
5 6
6 7
4 3
5 4
5 4
6 5
5 4
6 5
6 5
7 6
4 4
5 5
5 4
6 5
5 5
6 6
6 5
7 6
5 6
6 7
6 5
7 6
6 3
7 4
7 4
8 5
3 4
4 5
4 5
5 6
4 4
5 5
5 4
6 5
4 5
5 6
5 5
6 6
5 6
6 7
6 5
7 6
4 4
5 5
5 5
6 6
5 5
6 6
6 6
7 7
5 5
6 6
6 5
7 6
6 6
7 7
7 6
8 7
4 7
5 8
5 6
6 7
5 4
6 5
6 5
7 6
5 5
6 6
6 6
7 7
6 5
7 6
7 5
8 6
5 6
6 7
6 6
7 7
6 7
7 8
7 6
8 7
6 5
7 6
7 6
8 7
7 6
8 7
8 7
9 8
2 6
3 7
3 6
4 7
3 7
4 8
4 7
5 8
3 8
4 9
4 7
5 8
4 4
5 5
5 5
6 6
3 5
4 6
4 6
5 7
4 5
5 6
5 5
6 6
4 6
5 7
5 6
6 7
5 7
6 8
6 6
7 7
3 1
4 2
4 2
5 3
4 2
5 3
5 3
6 4
4 2
5 3
5 2
6 3
5 3
6 4
6 3
7 4
4 4
5 5
5 3
6 4
5 2
6 3
6 3
7 4
5 3
6 4
6 4
7 5
6 3
7 4
7 3
8 4
3 4
4 5
4 4
5 5
4 5
5 6
5 4
6 5
4 2
5 3
5 3
6 4
5 3
6 4
6 4
7 5
4 3
5 4
5 3
6 4
5 4
6 5
6 4
7 5
5 5
6 6
6 4
7 5
6 3
7 4
7 4
8 5
4 4
5 5
5 5
6 6
5 4
6 5
6 4
7 5
5 5
6 6
6 5
7 6
6 6
7 7
7 5
8 6
5 2
6 3
6 3
7 4
6 3
7 4
7 4
8 5
6 3
7 4
7 3
8 4
7 4
8 5
8 4
9 5
3 5
4 6
4 4
5 5
4 2
5 3
5 3
6 4
4 3
5 4
5 4
6 5
5 3
6 4
6 3
7 4
4 4
5 5
5 4
6 5
5 5
6 6
6 4
7 5
5 3
6 4
6 4
7 5
6 4
7 5
7 5
8 6
4 4
5 5
5 4
6 5
5 5
6 6
6 5
7 6
5 6
6 7
6 5
7 6
6 3
7 4
7 4
8 5
5 4
6 5
6 5
7 6
6 4
7 5
7 4
8 5
6 5
7 6
7 5
8 6
7 6
8 7
8 5
9 6
4 4
5 5
5 5
6 6
5 5
6 6
6 6
7 7
5 5
6 6
6 5
7 6
6 6
7 7
7 6
8 7
5 7
6 8
6 6
7 7
6 3
7 4
7 4
8 5
6 4
7 5
7 5
8 6
7 4
8 5
8 4
9 5
5 5
6 6
6 5
7 6
6 6
7 7
7 5
8 6
6 1', '1000
5001
5002
5003
5004
5005
5006
5007
5008
5009
5010
5011
5012
5013
5014
5015
5016
5017
5018
5019
5020
5021
5022
5023
5024
5025
5026
5027
5028
5029
5030
5031
5032
5033
5034
5035
5036
5037
5038
5039
5040
5041
5042
5043
5044
5045
5046
5047
5048
5049
5050
5051
5052
5053
5054
5055
5056
5057
5058
5059
5060
5061
5062
5063
5064
5065
5066
5067
5068
5069
5070
5071
5072
5073
5074
5075
5076
5077
5078
5079
5080
5081
5082
5083
5084
5085
5086
5087
5088
5089
5090
5091
5092
5093
5094
5095
5096
5097
5098
5099
5100
5101
5102
5103
5104
5105
5106
5107
5108
5109
5110
5111
5112
5113
5114
5115
5116
5117
5118
5119
5120
5121
5122
5123
5124
5125
5126
5127
5128
5129
5130
5131
5132
5133
5134
5135
5136
5137
5138
5139
5140
5141
5142
5143
5144
5145
5146
5147
5148
5149
5150
5151
5152
5153
5154
5155
5156
5157
5158
5159
5160
5161
5162
5163
5164
5165
5166
5167
5168
5169
5170
5171
5172
5173
5174
5175
5176
5177
5178
5179
5180
5181
5182
5183
5184
5185
5186
5187
5188
5189
5190
5191
5192
5193
5194
5195
5196
5197
5198
5199
5200
5201
5202
5203
5204
5205
5206
5207
5208
5209
5210
5211
5212
5213
5214
5215
5216
5217
5218
5219
5220
5221
5222
5223
5224
5225
5226
5227
5228
5229
5230
5231
5232
5233
5234
5235
5236
5237
5238
5239
5240
5241
5242
5243
5244
5245
5246
5247
5248
5249
5250
5251
5252
5253
5254
5255
5256
5257
5258
5259
5260
5261
5262
5263
5264
5265
5266
5267
5268
5269
5270
5271
5272
5273
5274
5275
5276
5277
5278
5279
5280
5281
5282
5283
5284
5285
5286
5287
5288
5289
5290
5291
5292
5293
5294
5295
5296
5297
5298
5299
5300
5301
5302
5303
5304
5305
5306
5307
5308
5309
5310
5311
5312
5313
5314
5315
5316
5317
5318
5319
5320
5321
5322
5323
5324
5325
5326
5327
5328
5329
5330
5331
5332
5333
5334
5335
5336
5337
5338
5339
5340
5341
5342
5343
5344
5345
5346
5347
5348
5349
5350
5351
5352
5353
5354
5355
5356
5357
5358
5359
5360
5361
5362
5363
5364
5365
5366
5367
5368
5369
5370
5371
5372
5373
5374
5375
5376
5377
5378
5379
5380
5381
5382
5383
5384
5385
5386
5387
5388
5389
5390
5391
5392
5393
5394
5395
5396
5397
5398
5399
5400
5401
5402
5403
5404
5405
5406
5407
5408
5409
5410
5411
5412
5413
5414
5415
5416
5417
5418
5419
5420
5421
5422
5423
5424
5425
5426
5427
5428
5429
5430
5431
5432
5433
5434
5435
5436
5437
5438
5439
5440
5441
5442
5443
5444
5445
5446
5447
5448
5449
5450
5451
5452
5453
5454
5455
5456
5457
5458
5459
5460
5461
5462
5463
5464
5465
5466
5467
5468
5469
5470
5471
5472
5473
5474
5475
5476
5477
5478
5479
5480
5481
5482
5483
5484
5485
5486
5487
5488
5489
5490
5491
5492
5493
5494
5495
5496
5497
5498
5499
5500
5501
5502
5503
5504
5505
5506
5507
5508
5509
5510
5511
5512
5513
5514
5515
5516
5517
5518
5519
5520
5521
5522
5523
5524
5525
5526
5527
5528
5529
5530
5531
5532
5533
5534
5535
5536
5537
5538
5539
5540
5541
5542
5543
5544
5545
5546
5547
5548
5549
5550
5551
5552
5553
5554
5555
5556
5557
5558
5559
5560
5561
5562
5563
5564
5565
5566
5567
5568
5569
5570
5571
5572
5573
5574
5575
5576
5577
5578
5579
5580
5581
5582
5583
5584
5585
5586
5587
5588
5589
5590
5591
5592
5593
5594
5595
5596
5597
5598
5599
5600
5601
5602
5603
5604
5605
5606
5607
5608
5609
5610
5611
5612
5613
5614
5615
5616
5617
5618
5619
5620
5621
5622
5623
5624
5625
5626
5627
5628
5629
5630
5631
5632
5633
5634
5635
5636
5637
5638
5639
5640
5641
5642
5643
5644
5645
5646
5647
5648
5649
5650
5651
5652
5653
5654
5655
5656
5657
5658
5659
5660
5661
5662
5663
5664
5665
5666
5667
5668
5669
5670
5671
5672
5673
5674
5675
5676
5677
5678
5679
5680
5681
5682
5683
5684
5685
5686
5687
5688
5689
5690
5691
5692
5693
5694
5695
5696
5697
5698
5699
5700
5701
5702
5703
5704
5705
5706
5707
5708
5709
5710
5711
5712
5713
5714
5715
5716
5717
5718
5719
5720
5721
5722
5723
5724
5725
5726
5727
5728
5729
5730
5731
5732
5733
5734
5735
5736
5737
5738
5739
5740
5741
5742
5743
5744
5745
5746
5747
5748
5749
5750
5751
5752
5753
5754
5755
5756
5757
5758
5759
5760
5761
5762
5763
5764
5765
5766
5767
5768
5769
5770
5771
5772
5773
5774
5775
5776
5777
5778
5779
5780
5781
5782
5783
5784
5785
5786
5787
5788
5789
5790
5791
5792
5793
5794
5795
5796
5797
5798
5799
5800
5801
5802
5803
5804
5805
5806
5807
5808
5809
5810
5811
5812
5813
5814
5815
5816
5817
5818
5819
5820
5821
5822
5823
5824
5825
5826
5827
5828
5829
5830
5831
5832
5833
5834
5835
5836
5837
5838
5839
5840
5841
5842
5843
5844
5845
5846
5847
5848
5849
5850
5851
5852
5853
5854
5855
5856
5857
5858
5859
5860
5861
5862
5863
5864
5865
5866
5867
5868
5869
5870
5871
5872
5873
5874
5875
5876
5877
5878
5879
5880
5881
5882
5883
5884
5885
5886
5887
5888
5889
5890
5891
5892
5893
5894
5895
5896
5897
5898
5899
5900
5901
5902
5903
5904
5905
5906
5907
5908
5909
5910
5911
5912
5913
5914
5915
5916
5917
5918
5919
5920
5921
5922
5923
5924
5925
5926
5927
5928
5929
5930
5931
5932
5933
5934
5935
5936
5937
5938
5939
5940
5941
5942
5943
5944
5945
5946
5947
5948
5949
5950
5951
5952
5953
5954
5955
5956
5957
5958
5959
5960
5961
5962
5963
5964
5965
5966
5967
5968
5969
5970
5971
5972
5973
5974
5975
5976
5977
5978
5979
5980
5981
5982
5983
5984
5985
5986
5987
5988
5989
5990
5991
5992
5993
5994
5995
5996
5997
5998
5999
6000', '6 3
6 3
7 4
6 3
7 4
7 4
8 5
5 3
6 4
6 3
7 4
6 4
7 5
7 4
8 5
6 5
7 6
7 4
8 5
7 3
8 4
8 4
9 5
5 4
6 5
6 5
7 6
6 4
7 5
7 4
8 5
6 5
7 6
7 5
8 6
7 6
8 7
8 5
9 6
6 3
7 4
7 4
8 5
7 4
8 5
8 5
9 6
7 4
8 5
8 4
9 5
8 5
9 6
9 5
10 6
5 6
6 7
6 5
7 6
6 4
7 5
7 5
8 6
6 5
7 6
7 6
8 7
7 5
8 6
8 5
9 6
6 6
7 7
7 6
8 7
7 7
8 8
8 6
9 7
7 3
8 4
8 4
9 5
8 4
9 5
9 5
10 6
6 4
7 5
7 4
8 5
7 5
8 6
8 5
9 6
7 6
8 7
8 5
9 6
8 3
9 4
9 4
10 5
7 4
8 5
8 5
9 6
8 4
9 5
9 4
10 5
8 5
9 6
9 5
10 6
9 6
10 7
10 5
11 6
2 4
3 5
3 5
4 6
3 5
4 6
4 6
5 7
3 5
4 6
4 5
5 6
4 6
5 7
5 6
6 7
3 7
4 8
4 6
5 7
4 4
5 5
5 5
6 6
4 5
5 6
5 6
6 7
5 5
6 6
6 5
7 6
3 6
4 7
4 6
5 7
4 7
5 8
5 6
6 7
4 5
5 6
5 6
6 7
5 6
6 7
6 7
7 8
4 6
5 7
5 6
6 7
5 7
6 8
6 7
7 8
5 8
6 9
6 7
7 8
6 4
7 5
7 5
8 6
3 5
4 6
4 6
5 7
4 5
5 6
5 5
6 6
4 6
5 7
5 6
6 7
5 7
6 8
6 6
7 7
4 3
5 4
5 4
6 5
5 4
6 5
6 5
7 6
5 4
6 5
6 4
7 5
6 5
7 6
7 5
8 6
4 6
5 7
5 5
6 6
5 4
6 5
6 5
7 6
5 5
6 6
6 6
7 7
6 5
7 6
7 5
8 6
5 6
6 7
6 6
7 7
6 7
7 8
7 6
8 7
6 4
7 5
7 5
8 6
7 5
8 6
8 6
9 7
3 5
4 6
4 5
5 6
4 6
5 7
5 6
6 7
4 7
5 8
5 6
6 7
5 5
6 6
6 6
7 7
4 6
5 7
5 7
6 8
5 6
6 7
6 6
7 7
5 7
6 8
6 7
7 8
6 8
7 9
7 7
8 8
4 4
5 5
5 5
6 6
5 5
6 6
6 6
7 7
5 5
6 6
6 5
7 6
6 6
7 7
7 6
8 7
5 7
6 8
6 6
7 7
6 4
7 5
7 5
8 6
6 5
7 6
7 6
8 7
7 5
8 6
8 5
9 6
4 6
5 7
5 6
6 7
5 7
6 8
6 6
7 7
5 5
6 6
6 6
7 7
6 6
7 7
7 7
8 8
5 6
6 7
6 6
7 7
6 7
7 8
7 7
8 8
6 8
7 9
7 7
8 8
7 5
8 6
8 6
9 7
5 6
6 7
6 7
7 8
6 6
7 7
7 6
8 7
6 7
7 8
7 7
8 8
7 8
8 9
8 7
9 8
6 6
7 7
7 7
8 8
7 7
8 8
8 8
9 9
7 7
8 8
8 7
9 8
8 8
9 9
9 8
10 9
3 9
4 10
4 8
5 9
4 5
5 6
5 6
6 7
4 6
5 7
5 7
6 8
5 6
6 7
6 6
7 7
4 7
5 8
5 7
6 8
5 8
6 9
6 7
7 8
5 3
6 4
6 4
7 5
6 4
7 5
7 5
8 6
4 4
5 5
5 4
6 5
5 5
6 6
6 5
7 6
5 6
6 7
6 5
7 6
6 4
7 5
7 5
8 6
5 5
6 6
6 6
7 7
6 5
7 6
7 5
8 6
6 6
7 7
7 6
8 7
7 7
8 8
8 6
9 7
4 4
5 5
5 5
6 6
5 5
6 6
6 6
7 7
5 5
6 6
6 5
7 6
6 6
7 7
7 6
8 7
5 7
6 8
6 6
7 7
6 5
7 6
7 6
8 7
6 6
7 7
7 7
8 8
7 6
8 7
8 6
9 7
5 7
6 8
6 7
7 8
6 8
7 9
7 7
8 8
6 4
7 5
7 5
8 6
7 5
8 6
8 6
9 7
6 5
7 6
7 5
8 6
7 6
8 7
8 6
9 7
7 7
8 8
8 6
9 7
8 4
9 5
9 5
10 6
4 5
5 6
5 6
6 7
5 5
6 6
6 5
7 6
5 6
6 7
6 6
7 7
6 7
7 8
7 6
8 7
5 5
6 6
6 6
7 7
6 6
7 7
7 7
8 8
6 6
7 7
7 6
8 7
7 7
8 8
8 7
9 8
5 8
6 9
6 7
7 8
6 5
7 6
7 6
8 7
6 6
7 7
7 7
8 8
7 6
8 7
8 6
9 7
6 7
7 8
7 7
8 8
7 8
8 9
8 7
9 8
7 6
8 7
8 7
9 8
8 7
9 8
9 8
10 9
5 7
6 8
6 7
7 8
6 8
7 9
7 8
8 9
6 9
7 10
7 8
8 9
7 5
8 6
8 6
9 7
6 6
7 7
7 7
8 8
7 6
8 7
8 6
9 7
7 7
8 8
8 7
9 8
8 8
9 9
9 7
10 8
6 4
7 5
7 5
8 6
7 5
8 6
8 6
9 7
7 5
8 6
8 5
9 6
8 6
9 7
9 6
10 7
7 7
8 8
8 6
9 7
8 5
9 6
9 6
10 7
8 6
9 7
9 7
10 8
9 6
10 7
10 6
11 7
3 7
4 8
4 7
5 8
4 8
5 9
5 7
6 8
4 5
5 6
5 6
6 7
5 6
6 7
6 7
7 8
4 6
5 7
5 6
6 7
5 7
6 8
6 7
7 8
5 8
6 9
6 7
7 8
6 6
7 7
7 7
8 8
4 7
5 8
5 8
6 9
5 7
6 8
6 7
7 8
5 8
6 9
6 8
7 9
6 9
7 10
7 8
8 9
5 5
6 6
6 6
7 7
6 6
7 7
7 7
8 8
6 6
7 7
7 6
8 7
7 7
8 8
8 7
9 8
4 8
5 9
5 7
6 8
5 5
6 6
6 6
7 7
5 6
6 7
6 7
7 8
6 6
7 7
7 6
8 7
5 7
6 8
6 7
7 8
6 8
7 9
7 7
8 8
6 6
7 7
7 7
8 8
7 7
8 8
8 8
9 9
5 7
6 8
6 7
7 8
6 8
7 9
7 8
8 9
6 9
7 10
7 8
8 9
7 6
8 7
8 7
9 8
6 7
7 8
7 8
8 9
7 7
8 8
8 7
9 8
7 8
8 9
8 8
9 9
8 9
9 10
9 8
10 9
4 7
5 8
5 8
6 9
5 8
6 9
6 9
7 10
5 8
6 9
6 8
7 9
6 9
7 10
7 9
8 10
5 10
6 11
6 9
7 10
6 6
7 7
7 7
8 8
6 7
7 8
7 8
8 9
7 7
8 8
8 7
9 8
5 8
6 9
6 8
7 9
6 9
7 10
7 8
8 9
6 3
7 4
7 4
8 5
7 4
8 5
8 5
9 6
6 4
7 5
7 4
8 5
7 5
8 6
8 5
9 6
7 6
8 7
8 5
9 6
8 4
9 5
9 5
10 6
5 5
6 6
6 6
7 7
6 5
7 6
7 5
8 6
6 6
7 7
7 6
8 7
7 7
8 8
8 6
9 7
6 4
7 5
7 5
8 6
7 5
8 6
8 6
9 7
7 5
8 6
8 5
9 6
8 6
9 7
9 6
10 7
6 7
7 8
7 6
8 7
7 5
8 6
8 6
9 7
7 6
8 7
8 7
9 8
8 6
9 7
9 6
10 7
7 7
8 8
8 7
9 8
8 8
9 9
9 7
10 8
8 4
9 5
9 5
10 6
9 5
10 6
10 6
11 7
4 5
5 6
5 5
6 6
5 6
6 7
6 6
7 7
5 7
6 8
6 6
7 7
6 4
7 5
7 5
8 6
5 5
6 6
6 6
7 7
6 5
7 6
7 5
8 6
6 6
7 7
7 6
8 7
7 7
8 8
8 6
9 7
5 5
6 6
6 6
7 7
6 6
7 7
7 7
8 8
6 6
7 7
7 6
8 7
7 7
8 8
8 7
9 8
6 8
7 9
7 7
8 8
7 5
8 6
8 6
9 7
7 6
8 7
8 7
9 8
8 6
9 7
9 6
10 7
5 7
6 8
6 7
7 8
6 8
7 9
7 7
8 8
6 6
7 7
7 7
8 8
7 7
8 8
8 8
9 9
6 7
7 8
7 7
8 8
7 8
8 9
8 8
9 9
7 9
8 10
8 8
9 9
8 5
9 6
9 6
10 7
6 6
7 7
7 7
8 8
7 6
8 7
8 6
9 7
7 7
8 8
8 7
9 8
8 8
9 9
9 7
10 8
7 2');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (9, 10035, 'Primary Arithmetic', '10035 - Primary Arithmetic', 'https://onlinejudge.org/external/100/p10035.pdf', 1, '//uva10035
#include <iostream>
#include <stack>
using namespace std;

int main() {
	int n, m, a, b, carry, count;

	scanf(\"%d%d\", &n, &m);
	while (n != 0 || m != 0) {
		carry = 0;
		count = 0;
		while (n > 0 || m > 0) {
			if (n % 10 + m % 10 + carry >= 10) {
				++count;
				carry = 1;
			}
			else
				carry = 0;
			n /= 10;
			m /= 10;
		}

		if (count <= 1)
			if (count == 0)
				cout << \"No carry operation.\\n\";
			else
				cout << \"1 carry operation.\\n\";
		else
			cout << count << \" carry operations.\\n\";

		scanf(\"%d%d\", &n, &m);
	}

	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '123 456
555 555
123 594
2 3
5 5
3 9
18 7
10 99
23 48
34 13
46 54
23 93
238 384
2873 8892
8623 2548
23849 34034
23 93450
2 92340034
99 123456789
123289 230403
8383843 58940945
34997030 89349944
344984345 398495404
288092388 813940234
288092388 733940234
222222222 333333333
999999999 999999999
0 0', 'No carry operation.
3 carry operations.
1 carry operation.
No carry operation.
1 carry operation.
1 carry operation.
1 carry operation.
1 carry operation.
1 carry operation.
No carry operation.
2 carry operations.
1 carry operation.
2 carry operations.
3 carry operations.
3 carry operations.
1 carry operation.
No carry operation.
No carry operation.
2 carry operations.
1 carry operation.
4 carry operations.
5 carry operations.
4 carry operations.
7 carry operations.
7 carry operations.
No carry operation.
9 carry operations.', '2323 3232
8 9
923 2934
283 48
66 74
37 63
238 384
2234873 882392
868323 2976548
2384934 34087734
223843 3450987
23492 92349487
9234899 12333789
13428 2435303
1232323 52444423
3492330 89345944
344234324 388889934
774975588 813236667
288092388 723409129
524525352 424444242
999999999 999999999
0 0', 'No carry operation.
1 carry operation.
1 carry operation.
2 carry operations.
2 carry operations.
2 carry operations.
2 carry operations.
4 carry operations.
4 carry operations.
3 carry operations.
3 carry operations.
2 carry operations.
4 carry operations.
1 carry operation.
No carry operation.
3 carry operations.
6 carry operations.
7 carry operations.
7 carry operations.
No carry operation.
9 carry operations.');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (10, 10038, 'Jolly Jumpers', '10038 - Jolly Jumpers', 'https://onlinejudge.org/external/100/p10038.pdf', 1, '//uva10038
#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
	bool isJolly;
	int dataNum, *data;
	vector<int> minus;

	while(cin >> dataNum) {	// 紀錄序列長度
		// 初始化
		data = new int [dataNum];
		minus.clear();
		isJolly = true;

		// 紀錄整數序列
		for(int d = 0; d < dataNum; d++)
			cin >> data[d];

		// 計算相鄰二數之差值
		for(int i = 1; i < dataNum; i++)
			minus.push_back(abs(data[i] - data[i - 1]));

		// 排序
		sort(minus.begin(), minus.end());

		// 判斷是否為 Jolly jumper
		for(int i = 0; i < minus.size() && isJolly; i++)
			if(minus[i] != i + 1)
				isJolly = false;

		// 輸出判斷結果
		if(isJolly)
			cout << \"Jolly\" << endl;
		else
			cout << \"Not jolly\" << endl;

		// 釋放記憶體
		delete [] data;
	}

	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '10 8 -1 -1 5 -4 10 6 -8 -5 6
10 -18 -21 -13 -14 -8 -12 -14 -5 2 7
10 -18 -21 -13 -14 -8 -12 -14 -8 -1 4
20 -12 13 0 -4 3 11 -10 -18 15 -11 20 -12 -14 16 2 -12 -17 18 -2 17
20 -16 -15 -17 -20 -16 -11 -5 2 10 1 11 0 -12 -25 -11 4 -12 5 23 4
20 -9 -23 -32 -29 -22 -21 -37 -48 -33 -46 -63 -59 -78 -70 -88 -90 -85 -91 -81 -93
30 24 1 -29 12 -22 7 13 -20 16 0 -2 -7 19 9 21 -10 -9 -5 12 -18 2 -15 -15 15 26 7 -21 -3 -22 -22
30 -14 -13 -11 -8 -4 1 -5 2 -6 3 -7 4 -8 5 -9 6 -10 7 -11 8 -12 9 -13 10 -14 11 -15 12 -16 13
30 -9 -2 18 5 -14 1 -5 -1 7 -14 12 7 -21 4 -19 -8 9 0 -2 22 -5 5 -24 -8 4 -18 -17 1 -13 -10
2 3 3
2 6 7
3000 768 16 -1343 2650 -753 309 -1494 1909 473 2191 -2034 -2549 672 -2280 -132 -345 -725 -484 597 1024 1246 1465 2752 1635 -2935 1328 2619 -269 1087 1979 106 525 -2445 30 165 2088 2058 -638 -2675 1376 1464 516 -1786 -2237 1620 -1571 -243 -197 -692 -955 2040 -1790 2778 705 -1188 1686 -1626 299 1037 -2244 2192 -879 -1912 -1560 -1290 1085 1877 971 395 388 315 -1348 -1855 2854 -2453 428 -2100 -1606 1696 -2532 2366 -2104 2512 1509 -2334 -2045 2783 -1689 -706 485 -1477 141 -2333 225 -1484 -2747 1139 2859 -2999 2622 -215 -2862 461 -1157 -1135 -390 -2655 -2273 -2805 -1140 1000 -736 1600 2885 -958 -1818 2189 -189 -1275 -2526 -1431 -204 -1752 -521 231 -476 116 -509 -2437 -2658 -604 -1360 -2662 2761 1466 -2274 2368 1862 -2923 -2813 1596 -1291 -742 -1555 -4 177 2619 -2899 -730 1922 1990 347 -1484 713 -2027 -858 -1540 -227 -884 1157 -1128 743 1321 -809 318 -644 1091 -342 -2668 -987 2965 445 757 -2744 -1748 -2381 -2018 -1607 1459 2163 2739 -745 -798 1286 -462 -2941 -849 1197 991 135 -217 2494 -2851 2924 1704 -697 2667 2748 362 -2445 2265 1475 -2351 2378 -2373 912 343 2982 343 -1676 2733 2677 2915 -2325 1614 1890 -2985 -2870 1508 937 -1901 -1488 -2076 2474 -420 -361 -2328 1810 -697 -2735 1727 -2649 2570 -2227 -184 -27 2115 590 -1933 2627 -1755 -2872 -2073 -131 -2692 -2336 1113 -2437 -1823 -667 1648 80 -2959 -2812 2711 1424 369 1626 -1535 -526 1124 2501 -2292 2062 -683 2709 1793 -2101 -1174 7 674 2798 -367 1476 311 2082 -1346 -2135 938 130 2722 504 -2943 -480 1135 -1167 -906 -377 -1082 795 1870 1604 2306 2038 483 2980 1267 405 -366 797 -722 818 71 -2168 2339 111 -380 -2335 648 -1219 -1417 -2853 2109 1002 1152 -1946 -390 945 -2121 -1666 -2037 2523 1932 -4 -167 455 -1383 1700 -1855 -269 -667 -2707 2493 -2317 1633 -426 -1428 -2803 -1259 2968 2118 -1609 2252 -744 -589 642 2329 1523 -46 2670 -1946 -1776 -1867 -1099 1525 -2885 1030 -1549 1066 -1466 -1741 266 2392 -2338 -1665 626 -1608 1414 -1570 -1162 903 -2452 -2951 -1845 1489 -2163 -1595 -2234 2045 -480 -1088 2208 2766 437 -2596 1573 406 -2879 1048 445 -1077 -1328 951 985 -369 -461 -186 -1532 378 2259 2818 1914 -56 591 2576 -298 -2214 312 -2137 -2886 -1868 -1279 -547 1029 -1916 2480 -2828 2723 -1252 1722 1415 -2705 -171 -1843 1605 205 89 -1358 -2485 1759 -2182 -1938 1273 -1691 -88 1101 -472 2501 -2344 277 -1773 2659 1036 -1028 39 -728 369 -717 2140 -652 2904 2759 -2968 -2637 1834 2874 949 1679 2951 1202 -2648 1712 965 -1129 -2721 1022 -1790 -992 -2239 -1588 2474 -644 -2218 -438 1509 -1924 -894 1356 -2093 1424 591 787 -2981 288 2379 -1560 -2692 2642 63 -647 -1442 -2237 -2000 1425 -1771 -2363 -562 759 142 2929 1529 -2866 1187 -27 1679 1936 -1295 72 -381 2605 2615 -2065 2458 -627 -2716 1395 -331 2208 2956 571 -1479 -1558 -430 65 -2648 -493 1604 -1715 2717 -1412 -1704 2845 1636 -639 -252 -1663 -1783 1531 -1412 624 -1855 571 -1750 -1984 1823 2394 2960 -2067 2888 -1016 1384 654 -617 2096 814 -759 -1658 2134 -425 -1895 678 564 1042 -895 -1908 2282 2621 -2969 1621 -2612 -2972 -31 -1086 2353 2306 2462 -913 -716 -2483 2849 -369 -500 503 2264 125 2244 852 -2165 -1220 986 -1824 -607 2577 548 284 -2979 -1194 2409 2505 682 1543 1627 2649 -2700 -578 -2727 -977 563 1412 131 -2492 -841 1216 2422 -2067 -1969 -2468 -221 -101 -2438 611 2473 -940 638 -2000 1557 244 2664 -2100 1089 -892 -1667 -1077 -2038 273 -1939 -2793 -2503 716 -1754 2859 -2060 -1072 146 1090 -329 1848 -1149 2405 -2857 -1712 -1705 -2219 -422 331 -2517 -1890 1412 -632 -1124 989 -1596 2687 -1250 1170 -2842 1700 -1567 -1462 2028 1245 -1291 1573 -2135 -93 -290 483 -267 -67 1275 1035 1041 2441 -267 -945 1749 -741 733 204 -2476 -1312 -2076 384 -1222 -1674 -760 -2629 1215 2927 464 -1400 1424 2901 2236 -2048 150 721 2618 -405 -664 124 -2127 2109 2989 1378 -2118 1429 273 1369 724 2508 -289 -1950 2045 -2106 -359 758 -468 1627 -2921 822 1464 785 2502 -438 -2832 -2537 -1736 503 746 -826 2353 -2139 868 -2181 2579 -855 -2478 -1412 -1197 285 403 -2481 -2513 -2462 1542 -1000 991 2060 1498 -2724 -873 2674 866 2996 262 -220 -2806 2404 1199 2796 2700 44 1561 -1843 -1583 -2618 -118 -1741 1407 -626 1292 1261 -584 -1020 -1142 -1369 1050 1652 -1582 1014 -1885 813 -1203 634 -1384 2837 2161 -2137 -834 888 -1024 -2669 444 -2892 692 -2889 2567 -2876 290 467 2735 2764 1479 -2744 -1946 -1335 2458 -1818 1545 572 -2074 -638 -380 2949 -1731 2678 982 2680 -940 -2398 -843 2584 -272 1563 2686 -2376 1109 341 1855 1111 2403 -877 -1897 -2234 1390 -307 -2669 716 2844 -26 726 -1766 -329 780 524 410 -1236 -1166 1990 -448 -800 -414 191 -393 -579 -1956 -2430 -329 2634 -2317 -441 2658 -1748 -749 -1256 -1183 1296 2952 1749 1981 562 1524 2424 797 -1060 -171 -587 -48 226 -2639 -327 -2585 -521 -1418 2352 -1795 424 1449 -1773 -1268 771 -1005 170 -524 -2450 -2664 -1536 -2524 1697 69 -2121 -326 -817 2615 814 737 -2930 -2738 -491 -845 -2660 -2381 -172 1609 -1444 2817 991 -645 -1161 244 -2869 -2466 -1636 932 -676 -424 2806 -2666 2470 -1890 718 -2995 -2840 856 -176 -2860 221 9 -2116 2498 -1413 1384 2974 -793 1210 -1647 -1758 -2049 -2568 -333 1911 2596 -2217 -700 74 53 -1335 -1099 -508 -2490 1645 -753 -2371 2600 -625 203 -1989 1209 -297 2010 -1342 1854 2397 2437 1049 343 2001 -17 -69 593 -1451 241 1775 2048 984 630 133 -2313 463 1908 2615 -2187 1128 2690 385 -584 1299 -2648 204 1322 2259 2428 814 480 -2441 1258 366 1870 -1816 -479 1651 720 2121 1299 -1819 -971 1060 -2964 147 -2968 555 762 -1291 1898 -2246 -290 -1867 -2084 -309 1590 90 257 -2417 719 2843 -881 2916 1040 -2280 -346 -2550 2625 -894 -431 1199 2615 238 -1644 -1000 808 1 -2399 2658 -2103 -1788 367 2107 2798 2757 -448 1094 1194 -273 -2577 -1384 -48 558 2878 -1348 -2620 -2362 1885 1658 -480 -1986 699 -1756 2822 163 -395 676 -684 -1072 997 -1885 -164 2621 -1082 -2761 -2990 2370 -1683 -1282 2998 2182 -1313 -395 1022 -708 767 -355 -2015 -2060 2463 916 333 -796 -674 -159 1848 -765 1830 -609 -2614 -267 -2583 494 -507 1310 104 -1323 2947 1114 -2588 1477 98 16 -2892 -989 2677 -728 -2116 2863 2677 122 2397 1866 -866 1689 458 1274 -2578 284 -1013 -2218 -1145 109 2129 2105 -354 2543 1414 -1534 2791 -115 -1685 2578 -703 -2220 2907 -334 2643 863 -1865 2529 -1971 -1962 2255 65 -1603 -2014 1214 -687 -1650 -2689 1759 -29 -2913 -1832 410 -289 1438 1419 1204 -831 1741 713 -270 -999 -2957 1029 1156 1854 951 2810 -2964 -1987 -59 1309 902 229 -1781 -260 -279 -990 -1406 -1916 2733 -1369 -544 -603 263 13 -1316 2708 -85 1916 -1039 1495 -1754 1948 -3 2627 1775 -1824 2382 -1223 662 2123 2100 -1096 -1731 2139 2064 2657 818 -2783 -1253 2714 1984 -1814 -1892 888 -1803 -2838 2652 2516 -315 831 1271 1307 2970 2122 1479 -1718 1237 693 -2238 -68 -1870 1094 -1502 -2599 -2986 -1297 -1498 -994 2192 -2475 -94 2816 -1129 2238 777 -2127 -2648 -2200 1249 1567 -590 -2705 2270 -304 2402 -179 1145 -1914 2897 366 425 2952 -1462 1254 154 2607 1196 2272 1864 1889 -2347 1655 2864 -1234 2610 2532 2937 1264 -995 2414 1561 2537 2447 -2152 -1158 2301 -1257 2722 2759 1810 -103 606 -1544 -2007 -2366 2915 -480 -1743 -2655 2673 1868 1331 -457 -2527 2277 -358 -723 -1942 -2637 2445 -1085 625 -1075 1250 -2865 2160 -500 -1576 -2374 2347 -1382 2431 -1294 402 -296 -1684 762 -1571 1088 727 1802 -2374 -1511 1044 2212 -1674 -2422 -1194 -419 57 -1274 -1940 1449 2553 -1874 -2916 2023 -1815 162 -669 -245 -1743 494 -131 -1856 -2259 -2626 -279 -2011 2010 1919 2362 1286 -810 2452 211 1313 1566 -2997 360 -1392 -94 -2142 -2571 548 2848 -1201 810 806 -506 -1534 2892 -1609 -537 -2390 -985 -1376 -2576 -823 -583 822 -327 1966 384 474 823 -1163 2135 371 281 1818 2613 -1129 2065 1781 1840 608 2770 1480 -1369 2107 -1621 -2779 -780 -2646 -2232 -2289 268 2879 -120 -2635 1999 246 -1825 2512 1626 -157 -657 -102 680 933 -58 -1690 -861 1555 -1388 20 783 -241 506 -558 2030 -1241 -599 -1604 -275 2302 -693 1246 -2215 -1136 -2951 1066 -2254 -1823 -2872 2972 1598 2237 -846 1262 -2955 1171 2594 2807 330 1976 2275 -2663 1613 105 799 -2867 1228 -11 -2994 -2828 -1632 563 -161 -359 428 -712 1945 2831 -1729 -374 -131 2992 898 372 -701 1506 -2100 -1223 475 1609 -201 -2586 1096 2883 -1911 -580 1877 -676 -1994 1619 1770 2844 829 2736 2021 275 2392 -632 -1171 -2975 -2657 1995 2420 2968 1994 589 -243 -1432 1394 1137 1881 2590 2704 1352 -576 -498 1918 2580 1153 -2060 -2735 2732 364 2948 1786 -389 -1267 -1337 2742 -1945 -1800 -2989 -838 -2673 -2863 576 2062 -2761 -2448 2312 -2200 285 2734 -331 2762 -250 119 -1479 937 355 2915 -2059 -1175 -323 -1614 1243 423 1212 1859 2855 1987 -380 1532 2328 -1718 -2352 1386 826 -1085 -694 -1057 -2516 1852 -2857 895 -2729 -1484 2098 -1082 -1093 1517 -2401 2870 -1299 -1205 985 -1266 709 2806 1427 -557 1739 -1352 2196 -2406 -515 2866 -2686 600 1336 -1319 562 2392 -303 -943 -1373 -1507 2702 -2325 -2318 -1517 2352 -2850 2585 1968 2262 1145 -481 2548 2140 -2757 -105 -2836 -1206 -1480 -1935 -2677 2646 201 2762 2718 -1588 -2688 1336 -1690 -73 2078 697 -2688 -2148 1479 2059 -523 -1204 -2342 -1008 -1148 -2246 -439 -860 -1937 -511 -356 1376 2367 -2830 -2874 -1690 -326 -1496 1110 -1627 -1328 386 -2768 -2417 -1611 578 2229 1634 -2799 253 2199 -2985 -2933 2127 1320 -902 2073 1877 1122 -783 -2623 2352 -908 -274 -310 737 113 16 -440 -1889 1610 2073 -2080 867 109 -1973 1696 2154 783 2212 -179 -756 -1679 -1917 1775 2687 1802 1860 -1643 1126 -2245 1440 -2388 226 -2979 -2037 2369 -2134 -1541 2304 2484 -2049 -1094 45 2079 1060 -2804 -1176 -578 2981 -1420 -1088 352 -1724 -826 -478 1809 1837 337 -136 937 336 -2536 -1854 -2681 -1807 -2849 -1717 1454 2549 2228 -1884 1939 -1087 1901 1162 -275 -2981 633 -1626 1332 143 -814 2585 -669 739 1539 610 -202 -1272 -2447 1548 2553 327 -2985 -1406 378 1552 -1441 584 -1560 -2809 -936 1772 -2298 -1541 250 -2594 1186 -555 -385 2495 -1654 -1104 -1915 1572 -980 -568 -614 686 1268 -4 -492 -424 719 -383 500 -1309 -2711 -433 514 -1187 -1627 -1058 1274 1990 1701 2194 -784 -1183 -2638 547 1560 -459 -2538 2703 1153 853 -2371 -197 -2858 391 -1963 852 -1684 -2380 2433 403 2172 1236 -1110 2829 -2655 -2076 906 -342 -167 -578 677 -1767 263 -1299 288 1232 -2629 -2597 -1554 1555 962 1282 2291 268 353 -295 -1622 419 -1762 1662 -971 -2444 -2586 472 -778 1257 -2786 -2158 1694 1004 2371 -318 2550 -22 2930 1861 -1882 1454 1052 -872 2809 -2575 715 2165 -449 -315 2616 -1214 -1902 -33 -900 1506 -858 -201 -2249 -968 -369 2095 1142 404 -239 -2628 -2520 -2219 1151 -2997 2718 2569 864 410 -796 2324 -1167 788 910 2105 -2458 274 1969 596 -2004 767 -1017 -2465 -1266 -2857 -2374 1878 -2594 -136 -2780 1992 -2088 -2443 2279 2870 -9 706 -1552 -2693 2108 -1290 -2372 -2905 15 -2627 64 2354 -423 1189 -954 -423 -2102 -2386 1859 -2807 2811 2319 -952 -2684 -120 -2759 2523 -2672 -2271 -2393 -106 -2824 -1568 2800 2420 -112 -760 2109 -2518 2500 157 -2575 1877 -151 1122 -664 1463 -846 2509 2660 1252 -658 2478 -931 -1487 1556 539 2920 620 -867 -2969 356 1434 554 1820 -1583 -207 1297 -1737 -305 -1032 258 1109 1022 -2374 -309 -210 -1176 -328 2054 1427 -1736 -486 1665 2737 775 -434 831 223 1151 2433 -695 -2587 -987 -856 -2113 -445 1069 242 -47 -814 -2284 2813 419 -2129 -1779 -1281 98 2984 -938 -1591 -2569 -1673 32 -1035 -2653 -269 -1628 1598 2797 -38 -2184 -1501 2072 -1462 -2020 1545 -1715 -2401 -120 2314 2247 2863 -432 1082 2042 702 1489 2213 1887 1810 1605 -2815 1009 -875 1702 -1183 412 -2726 2250 -1607 726 2337 783 -1674 1141 -994 -1575 1719 2815 -730 -1838 -2171 2792 -2375 2325 1365 -585 65 1778 2038 -137 -2589 2601 2495 -1967 -1113 -2138 234 -78 1472 -2848 1718 -546 6 -1188 30 1470 -37 481 -1510 -825 -848 196 2031 -1115 -293 2603 828 -611 711 344 1207 428 633 -385 337 2787 522 132 -2209 -2335 -672 -914 40 -246 -1304 2630 -501 185 562 -2510 2711 2461 -2025 -2215 -1953 1423 -480 1425 -94 -995 1975 253 -929 2814 360 -512 -2654 1212 -1651 962 -2556 1031 -2113 -1209 1521 259 2598 -2630 -510 2304 -531 1553 64 -2159 -2762 -1711 -655 -1647 -2149 1992 2090 -548 -1179 1348 -1962 -1516 171 1875 2187 196 -1090 1087 1081 675 1848 2912 -723 267 1927 -2110 1553 -1027 -1809 -555 -2110 1598 -635 -421 -702 2936 2750 -2609 -351 -1902 2594 971 1489 -1119 -2482 -2040 -2915 644 2070 -1487 -1814 -2077 1112 -2183 -1965 2398 -53 -866 1347 2932 -644 -1814 -273 2774 2785 2900 1338 -1233 90 -160 1545 2301 -1788 -2226 -815 -843 -2834 -1897 -2945 1527 2343 707 1582 -900 -2666 1838 599 -2858 1709 -171 2836 10 2547 792 -2271 1483 -918 2652 2911 715 -1390 2085 2183 -123 2083 2456 1781 -215 1236 -2797 2073 -2760 611 -366 329 -2126 -1134 -738 -958 -1061 27 1407 -1902 -737 490 -890 1235 -614 -1883 -1725 -1272 -1970 718 2307 -1516 -1 -746 -2362 -1788 308 -215 2080 -2652 416 -488 -2683 -1966 -1884 -953 -936 -1227 534 1661 -1951 2530 -490 1811 2598 2113 21 1170 2205 -1465 1692 -1310 1813 1515 548 -1147 2742 2563 -2098 -1766 -1956 2940 -197 583 2189 1384 -1696 827 812 2536 2188 2245 1721 2579 -2893 572 -1968 2637 -691 -1683 1997 1083 -2290 -1411 -673 -1108 2240 2340 132 56 974 -2394 -1621 -594 1350 -1654 31 -2274 2542 23 -1560 -1177 1389 -2003 185 -892 -1372 1992 -1885 -199 155 -1925 -492 569 -586 -312 -1982 -2851 737 -151 2276 -2661 793 -1906 377 843 -2885 -74 -1416 2042 -2168 1382 -2872 -844 1424 -2596 -2154 -1671 860 2591 1211 -1809 -561 2532 -2788 2463 2337 713 823 -382 -1865 -844 -1761 818 1311 118 -1062 1035 -632 -2447 1490 1920 -516 -909 1291 2738 -1676 -2780 -2397 1758 1262 -2350 -356 693 -2996 2064 -277 2908 2409 676 -1871 -218 -663 818 1982 1587 -394 -2550 -2267 2728 1113 -2264 1872 1109 -1134 54 -1941 699 -1220 -2181 74 -2582 1630 -101 -2177 -175 1400 1165 2210 -2625 -2334 -2348 -712 2738 40 -880 -876 334 206 -1613 668 2906 1664 -1283 830 -656 -1014 -1315 -1195 2890 -979 -1592 -1056 -1813 -321 -1454 1269 -1147 2495 1657 2066 2634 1954 -142 -39 -2714 -1025 -1230 664 1519 2008 -2214 1772 -190 2590 328 1735 1065 -2686 -767 -2766 -2891 -893 -1982 1112 -43 1184 -549 2016 16 103 2496 -2240 -1057 1130 2875 -1013 -1901 364 2507 -452 -494 -2014 -2855 819 980 -2477 -1885 254 -1632 330 -2272 -2105 1948 -2563 -2257 298 -497 330 650 -336 -686 -531 2915 518 748 1750 -1110 133 -888 -2717 1270 -2277 2444 2972 1208 -2866 -2016 2931 -800 -925 172 1337 -2025 -1029 -1786 -2998 2370 268 -1423 -2002 2756 2491 1363 1037 -1407 1162 -937 1998 2261 -623 1885 2886 -2239 -1446 -242 -441 762 -735 -251 -2409 2598 -604 2444 -848 -1514 -2186 -2470 -302 -23 -1194 -2440 -763 -509 -2073 -15 -848 1600 -57 -1470 910 -2324 371 1563 2017 2313 1661 -111 1254 9 -1270 1235 1534 -602 1382 2190 2115 1424 1312 -1258 -2079 1993 920 -2895 -1552 135 2253 -1917 -2991 2144 -2596 -527 -852 -2696 -2758 -788 377 2820 -2394 -263 2259 -2399 -448 -1510 -1710 -2186 -663 -560 -2265 -1919 -75 236 -2283 1397 -455 1300 2651 -1175 2504 -55 2450 1960 -9 -1859 164 -1575 -144 2977 369 -2385 1702 2801 2939 891 2173 26 -1736 576 -2321 1196 -1246 -1706 -2577 1102 2283 382 1380 1723 794 -1574 1445 2650 684 1406 -154 1430 1774 1265 -463 2446 -1371 436 -2105 59 -187 -2498 -104 -2164 976 468 -976 -1928 -2556 2481 -2764 2642 -2696 -2230 -485 -2363 -1046 -236 164 -2435 1375 1372 -212 -2521 1100 -2754 2147 -1003 1802 -281 915 1374 489 1615 -950 -2358 -1730 2463 2421 2854 -2233 118 -2289 -1177 1845 -2470 -426 -2145 1780 292 881 -1935 -655 -1587 2983 -1014 2985 1420 -1866 1378 723 -2410 1203 2935 493 2880 598 1148 -1676 -870 26 -993 1336 -807 -886 -933 899 -1107 1393 734 2163 -2816 -686 2206 -67 2253 -1179 -389 -2832 -111 258 249 765 1893 -2920 1066 -1132 595 -58 -1428 1547 -1537 1715 1348 1462 -138 -1901 -2503 -2632 -173 -1628 2393 -788 991 754 -2351 1501 2730 -1685 -2962 260 -627 2948 -2008 -907 779 2765 643 1298 2601 -2612 -2814 2467 1183 406 655 2233 1414 2628 2986 -1605 -688 -1805 2695 -55 2948 -2492 2213 839 -2499 571 931 892 -1633
3000 9 288 -2050 -2317 -1671 -2164 -4156 -5631 -4789 -7614 -5321 -7126 -4562 -1911 -3032 -4380 -4231 -3980 -5634 -5675 -7725 -10092 -12755 -11707 -9482 -11315 -10237 -9009 -9314 -10059 -11797 -9135 -8934 -10537 -10285 -10828 -11355 -11680 -14188 -16747 -16511 -18055 -18574 -21218 -19291 -19766 -17488 -15486 -14896 -12939 -15126 -14277 -16126 -17672 -17990 -20410 -21770 -19194 -20656 -19031 -17755 -19208 -20202 -20705 -20722 -20572 -22696 -23768 -21700 -24693 -26784 -28231 -26079 -26728 -25335 -27609 -30297 -32326 -29500 -29766 -31529 -30945 -32767 -35716 -38622 -38762 -40701 -39452 -37163 -37528 -36933 -35338 -37730 -34814 -34858 -35709 -33537 -35460 -33076 -34434 -37216 -37092 -39481 -36768 -37198 -36628 -34794 -33336 -33552 -34927 -37798 -39978 -39658 -38473 -41416 -43027 -40783 -39957 -39649 -38442 -38273 -40567 -38923 -41385 -39375 -38459 -38575 -37829 -36013 -35916 -33683 -35213 -33363 -31593 -32773 -33921 -31759 -31299 -30957 -33507 -34126 -36434 -33549 -34046 -35474 -33680 -32735 -34648 -36415 -37850 -38174 -38877 -36484 -39111 -36279 -35560 -36142 -38530 -37466 -35540 -33145 -35214 -32314 -34375 -35827 -34559 -32893 -35850 -35725 -37937 -35852 -32875 -30604 -33029 -35985 -35256 -34631 -34331 -37133 -38114 -40062 -42028 -40173 -39187 -39329 -42191 -41091 -40557 -38027 -36772 -33900 -33509 -31045 -30685 -33334 -32459 -34489 -35912 -33245 -30265 -28473 -29088 -31084 -33737 -32510 -32613 -31442 -32183 -30936 -28531 -30271 -28096 -28651 -28639 -29240 -26654 -24423 -24290 -23503 -21802 -19487 -17804 -17312 -19111 -20552 -21042 -19556 -18053 -19059 -21049 -23792 -25021 -24858 -22035 -24401 -27134 -26584 -27051 -28859 -26373 -26170 -27143 -30137 -28463 -30600 -28371 -26808 -28508 -27961 -25674 -25555 -25545 -27438 -30124 -31881 -31992 -33313 -33854 -31954 -29793 -32474 -29814 -27853 -26419 -26371 -26703 -26663 -26985 -28687 -28234 -28072 -26983 -28032 -30715 -33512 -34353 -32354 -31572 -34351 -33939 -35283 -36432 -38633 -36018 -36387 -35281 -35050 -33361 -35845 -38045 -40693 -42511 -42327 -40247 -38967 -40284 -41129 -39854 -41995 -44959 -43307 -42885 -45649 -44321 -46465 -48894 -51322 -52246 -52794 -53583 -56136 -55679 -55947 -57571 -55695 -53407 -54281 -54480 -52660 -53177 -53740 -54532 -53071 -54960 -56069 -55111 -56341 -57510 -55095 -54193 -52991 -52897 -50557 -47979 -49562 -52454 -52140 -54580 -55379 -56119 -56619 -55399 -56571 -58843 -61378 -58408 -56573 -55308 -57688 -60175 -63022 -63388 -61317 -63627 -61006 -59742 -58032 -59170 -56467 -54733 -54604 -52557 -52592 -52634 -55418 -54242 -56186 -54845 -56174 -57836 -56901 -57136 -58689 -58704 -59839 -60748 -61739 -62636 -64092 -67045 -64897 -67407 -65110 -66185 -66395 -68987 -67555 -69111 -67454 -69176 -68295 -70026 -68711 -71446 -71070 -72669 -70857 -71767 -74650 -74291 -72097 -72732 -74940 -73221 -71537 -69864 -67227 -67047 -65889 -66021 -64236 -64926 -64515 -67210 -69472 -67012 -65266 -63687 -63907 -61418 -59282 -58362 -55988 -53324 -53256 -55599 -54378 -54901 -55135 -55424 -55210 -55287 -54765 -54764 -52003 -50347 -52653 -50503 -47692 -48571 -51517 -50248 -50363 -53314 -56200 -53870 -55883 -56278 -54280 -55308 -57499 -55331 -54843 -53913 -55127 -54631 -55549 -52574 -54833 -56889 -54021 -56715 -58965 -56331 -55964 -55777 -58014 -57011 -58094 -59636 -56864 -59691 -60644 -59858 -61032 -61136 -63064 -64187 -62821 -65416 -64324 -66818 -67056 -65005 -64622 -63762 -63102 -64616 -67323 -64336 -62381 -60204 -62067 -62103 -62868 -61734 -63028 -63467 -64200 -63970 -62284 -60917 -62452 -63739 -62984 -60519 -59399 -57339 -55193 -54554 -54210 -51367 -48891 -48163 -50298 -47632 -48499 -47808 -48888 -49052 -46324 -43893 -44708 -44239 -43595 -41652 -39305 -37926 -36842 -33921 -34364 -33418 -35876 -33771 -33104 -33758 -34022 -34727 -37484 -37193 -37568 -35000 -36803 -35128 -37896 -36469 -38437 -40665 -43519 -41724 -43880 -42023 -41312 -39606 -39316 -37157 -35076 -32227 -31690 -30863 -31666 -29044 -29460 -28282 -26383 -27702 -26931 -27957 -28720 -26920 -24630 -27069 -26807 -28277 -30966 -32239 -29694 -32488 -34024 -36226 -38672 -40042 -42524 -42497 -41931 -39187 -36776 -35635 -35783 -34836 -33372 -30911 -33274 -33223 -32560 -30067 -32665 -34171 -33735 -33646 -35207 -33794 -33887 -35727 -37646 -39556 -41387 -40825 -43533 -42556 -43962 -44782 -42200 -45107 -44038 -44190 -44734 -45464 -46641 -44086 -45012 -43900 -41582 -40043 -41894 -44259 -43512 -42886 -44928 -42246 -39441 -40249 -40788 -41169 -38229 -37826 -37748 -39574 -36832 -35205 -34499 -37248 -37471 -35211 -33965 -32188 -31901 -33368 -33953 -32660 -33444 -32674 -32492 -30281 -32991 -30417 -27984 -25499 -27411 -29566 -26796 -25463 -23984 -21714 -19079 -20124 -17407 -19834 -19033 -19265 -19776 -20538 -22855 -20574 -18940 -18972 -20290 -17300 -16837 -18878 -20262 -21409 -20222 -18612 -20206 -22877 -20057 -22369 -24694 -24135 -21632 -21614 -19279 -21394 -21867 -20717 -20763 -23600 -22518 -22691 -21971 -21916 -24517 -22738 -21256 -21071 -22442 -23621 -25885 -23107 -25023 -26102 -25035 -23663 -21785 -19049 -17410 -15862 -16964 -18365 -19695 -19333 -16878 -15127 -14997 -16947 -15709 -14421 -17330 -16144 -18705 -16977 -15019 -17831 -16231 -14302 -15767 -14430 -16874 -15431 -12740 -10771 -9282 -12113 -10556 -13453 -15529 -18474 -15874 -16053 -16632 -16849 -15734 -18472 -20979 -23305 -20669 -20441 -23055 -21290 -22658 -20432 -18494 -20793 -20938 -22204 -22116 -24897 -24053 -25343 -23604 -23305 -26181 -29150 -31155 -30044 -31692 -28842 -27027 -27198 -28847 -26320 -26925 -25316 -24277 -22581 -23672 -23848 -23019 -25301 -22325 -25314 -27664 -27030 -25898 -25386 -26158 -27403 -24889 -24974 -25073 -24371 -26555 -27588 -26181 -25472 -24160 -25184 -24330 -23523 -24843 -23855 -21378 -22878 -23105 -23432 -21483 -19696 -20797 -22604 -21922 -21961 -21012 -22130 -23170 -22228 -22581 -25384 -22716 -24765 -24669 -27289 -30003 -28267 -27679 -30154 -32958 -31585 -30728 -31029 -33334 -35720 -33241 -36191 -36879 -36937 -38839 -40921 -41334 -41367 -39682 -37898 -36546 -39169 -37232 -36086 -33095 -32732 -31037 -32541 -31069 -33819 -34527 -35359 -32485 -30900 -28504 -26573 -25159 -27628 -27941 -29252 -29950 -32193 -30331 -32320 -31318 -32620 -31000 -31323 -30509 -28313 -26883 -24365 -26458 -25392 -26737 -26636 -28147 -27230 -24778 -24687 -26691 -24006 -21792 -24529 -22126 -23708 -23434 -22197 -22262 -20554 -22789 -24291 -22860 -21440 -19280 -18894 -18820 -20813 -19539 -22184 -22115 -22023 -21569 -24434 -24960 -24581 -23642 -25500 -24814 -23959 -23069 -22109 -22593 -23092 -25132 -25928 -28135 -26530 -27222 -27687 -29410 -28148 -28991 -29112 -31957 -29058 -26177 -24617 -26388 -28802 -27926 -30323 -27554 -27815 -29179 -26555 -24480 -22817 -24300 -26636 -24960 -26179 -26603 -24589 -25609 -23773 -24590 -25254 -27988 -30907 -28870 -30257 -28249 -27542 -25789 -26406 -26240 -23789 -23311 -22913 -21944 -20313 -23170 -22920 -21002 -19640 -19444 -20013 -20324 -17565 -18067 -19206 -21760 -20229 -19048 -18242 -20537 -23323 -23876 -25318 -25940 -24618 -25721 -25190 -22771 -23262 -25827 -25870 -28009 -28811 -30944 -32604 -34895 -33354 -30863 -33628 -31024 -33197 -33813 -35372 -35529 -35551 -36851 -39307 -39509 -38043 -40649 -42891 -44265 -42827 -42684 -40521 -43387 -43050 -44194 -45257 -47959 -50018 -47631 -45118 -42638 -40055 -41022 -39675 -37713 -34774 -36242 -38147 -40087 -41751 -39817 -38020 -35897 -36465 -35869 -35407 -35354 -33188 -33167 -30909 -33124 -35160 -36842 -36224 -36553 -38357 -36998 -36423 -37666 -37888 -37248 -38415 -40243 -41933 -43211 -41702 -40684 -43345 -45914 -43807 -41786 -43141 -44372 -47029 -45833 -44259 -42039 -41302 -43296 -43711 -43446 -41042 -39703 -39762 -40710 -41474 -43714 -43537 -45369 -47323 -46071 -48182 -45690 -44305 -46624 -47232 -45820 -43966 -42515 -43822 -43034 -45313 -45698 -47494 -48705 -45947 -46093 -47025 -45970 -47574 -45847 -45451 -45901 -46505 -48193 -47068 -47240 -46381 -44096 -44954 -46807 -47481 -50443 -48986 -51185 -51280 -51794 -52494 -53179 -54217 -51884 -53843 -55560 -53262 -53856 -53318 -51924 -53357 -55452 -58036 -57471 -56194 -57150 -59031 -59302 -60491 -59401 -58641 -57140 -55396 -56773 -56466 -54607 -54058 -51621 -51874 -54057 -56343 -55986 -56329 -54199 -54444 -55005 -53023 -55278 -57541 -55387 -55417 -52491 -53091 -50224 -49163 -51054 -52220 -53608 -53634 -55761 -54601 -54910 -57164 -58431 -60773 -61057 -60689 -62631 -61498 -63099 -62191 -60094 -62997 -61614 -60898 -63221 -65962 -64441 -62315 -60173 -61903 -63184 -62346 -59835 -60738 -63643 -60993 -60297 -60086 -59200 -57420 -54698 -57001 -58548 -60957 -60878 -63575 -60870 -60554 -57824 -54966 -57779 -54831 -53984 -51089 -53591 -51619 -50227 -47562 -48562 -51040 -53878 -51986 -50351 -51315 -51235 -49351 -51883 -53479 -51120 -50671 -50177 -51077 -53616 -55647 -53482 -54457 -54754 -53938 -55917 -53940 -56510 -56224 -57381 -60303 -57616 -59546 -60145 -62494 -63919 -65336 -62535 -62778 -62764 -59904 -58818 -56735 -55184 -56314 -55615 -52931 -52933 -53708 -53067 -51991 -53740 -51041 -51199 -51925 -49787 -48531 -46839 -48401 -47422 -50268 -49381 -49481 -46502 -44414 -42233 -45161 -44268 -41959 -42614 -45399 -43421 -44745 -45468 -44633 -44599 -47195 -45711 -44429 -45683 -46342 -48256 -47120 -45251 -48159 -48539 -47291 -48125 -49514 -47475 -49549 -51444 -54231 -53943 -51223 -53131 -56027 -53030 -50035 -52434 -53530 -52976 -51613 -50423 -49647 -50706 -50987 -49235 -49539 -48845 -50751 -49201 -50259 -50685 -53439 -52574 -54416 -51581 -50933 -50257 -52988 -53590 -56399 -56162 -58970 -59997 -58470 -56072 -58997 -61280 -58607 -59768 -59987 -57283 -58221 -56411 -53890 -52619 -52896 -53366 -52056 -52598 -55052 -56985 -58910 -60721 -60758 -62198 -62410 -64690 -65736 -63749 -63260 -64655 -65238 -68021 -66317 -66857 -67530 -68001 -67718 -70208 -68299 -69634 -67976 -67370 -66028 -68805 -70882 -68440 -69152 -72111 -69349 -67644 -69813 -68359 -67141 -68278 -68537 -66205 -68456 -70944 -72489 -70729 -70158 -67905 -65087 -65300 -68282 -68806 -68944 -66043 -68548 -70770 -71704 -73927 -74779 -72756 -71947 -70897 -70780 -72676 -74943 -73078 -71787 -73464 -73601 -75327 -76729 -74625 -73649 -72983 -72455 -73420 -73368 -73948 -75013 -73996 -72198 -69791 -70746 -71003 -71483 -71470 -71663 -68807 -67333 -65801 -64182 -63439 -64132 -64746 -63833 -61195 -61589 -60652 -58955 -60079 -58359 -60332 -63195 -60526 -60195 -62735 -64364 -67144 -65595 -66078 -65151 -66354 -65698 -66059 -68315 -67968 -66998 -69031 -69303 -69737 -67022 -68659 -66410 -64621 -62173 -60530 -62246 -64804 -65536 -63098 -65334 -67314 -64717 -62829 -65471 -64308 -62191 -61425 -64258 -65179 -65045 -67904 -65382 -66345 -66175 -64949 -64924 -62452 -63504 -62524 -60548 -62905 -64827 -67706 -70308 -69650 -66926 -64205 -62902 -62111 -60033 -60425 -61403 -63324 -64170 -64189 -61314 -61617 -60463 -63400 -63028 -64874 -64754 -66651 -68100 -69259 -71323 -70429 -70119 -70949 -69975 -68467 -69372 -71355 -72923 -71717 -72327 -72245 -74291 -74512 -77424 -75832 -73988 -74977 -77539 -76238 -76428 -73505 -71415 -72651 -72856 -74618 -73326 -75413 -74762 -76887 -76911 -77383 -77281 -79889 -80262 -79301 -77865 -77712 -79715 -77957 -78465 -75692 -73144 -74312 -73904 -74561 -74645 -76757 -75921 -73901 -74290 -77080 -75499 -75081 -75032 -75409 -77757 -78932 -77719 -79792 -77560 -76888 -76090 -74411 -77300 -76856 -77591 -80386 -78471 -79994 -79464 -77144 -76537 -77069 -78635 -79689 -77109 -79676 -76788 -79726 -81482 -83049 -81854 -84075 -81753 -81413 -83640 -82260 -83930 -83523 -84491 -86563 -88933 -88166 -87739 -88094 -85569 -84459 -87373 -86672 -85162 -82800 -82829 -82146 -84385 -82533 -83228 -84416 -81575 -82354 -80864 -83376 -86289 -85335 -83839 -84197 -85381 -82914 -83880 -84378 -83291 -85552 -82754 -83382 -81176 -80296 -82986 -84099 -81989 -79474 -76886 -78290 -76120 -76791 -77601 -78599 -78221 -75348 -72560 -70604 -69207 -67538 -67756 -66172 -63569 -64505 -65944 -64728 -66133 -65746 -67128 -65778 -64939 -62561 -62632 -65001 -62599 -61302 -63839 -66190 -64544 -65973 -68682 -65698 -66745 -64090 -65147 -63671 -62649 -59780 -59940 -60458 -58404 -56871 -58214 -55502 -55258 -52602 -55331 -57521 -55074 -54079 -53251 -55921 -56214 -54400 -55871 -57349 -58475 -58040 -56272 -58291 -58409 -57992 -56151 -58012 -58662 -58207 -60955 -63008 -64883 -63365 -64510 -62819 -61597 -64128 -65326 -66469 -67373 -65623 -67608 -68592 -71564 -71557 -68747 -68690 -71036 -73542 -71844 -71367 -69760 -68726 -71545 -71653 -72636 -74633 -73954 -73773 -75008 -74388 -74426 -74146 -73586 -76027 -74583 -71831 -71325 -73888 -72106 -73809 -72794 -75423 -75041 -73619 -72497 -71087 -69442 -71232 -70771 -72399 -75235 -75771 -75110 -72797 -70245 -70140 -70962 -72687 -69753 -66913 -68154 -67551 -65545 -65800 -68144 -69777 -72364 -69929 -70338 -72911 -75296 -74043 -73579 -74340 -73080 -75066 -72188 -73824 -72051 -74285 -72038 -70325 -70972 -68825 -71400 -70196 -69125 -69119 -67977 -69548 -66992 -64463 -61559 -59679 -58012 -55654 -57654 -54662 -56463 -56649 -55407 -56303 -58801 -56903 -58904 -56074 -59035 -56857 -55457 -56493 -55754 -55390 -54377 -52016 -54535 -56649 -57089 -54580 -53823 -54540 -54746 -56300 -56347 -57828 -55262 -55610 -56818 -58167 -60443 -57901 -60778 -59206 -57122 -57326 -58144 -60061 -58470 -58116 -55252 -57709 -59302 -58807 -56273 -57121 -59261 -61706 -60775 -62300 -61899 -63641 -65356 -65422 -64966 -67662 -68673 -69188 -67565 -68552 -67459 -67585 -65625 -66278 -64406 -63290 -63799 -66051 -66123 -68669 -70493 -67600 -67616 -69750 -67976 -68927 -71723 -72922 -71978 -73402 -74707 -72679 -73200 -74578 -77514 -77340 -77972 -77343 -76322 -76657 -75759 -75094 -72462 -69520 -69015 -70655 -73274 -71623 -70999 -71515 -69143 -70988 -69730 -70942 -70510 -70254 -72324 -70434 -69118 -70487 -69076 -66799 -64483 -65602 -66103 -64548 -63375 -62975 -65963 -66527 -63880 -62202 -63889 -62003 -62469 -61984 -63947 -64768 -65711 -63071 -64591 -65137 -67149 -69119 -69706 -67134 -70119 -67819 -70739 -70641 -73407 -76374 -75134 -77435 -79963 -77439 -79799 -81637 -81876 -84121 -82608 -80541 -82627 -83515 -84202 -84653 -86620 -85780 -87715 -86814 -85307 -84733 -87342 -84819 -87520 -88288 -88296 -88742 -86336 -83512 -83439 -85390 -87682 -89222 -89500 -86501 -87128 -88745 -89274 -89608 -88115 -86098 -88697 -89490 -89842 -89018 -89686 -88808 -86603 -88985 -91926 -93031 -91534 -91788 -92469 -90652 -91581 -94579 -94929 -95609 -98499 -101350 -100936 -98925 -97725 -97496 -100357 -98743 -98470 -96761 -96371 -97196 -97502 -98139 -97944 -98489 -100737 -98635 -100673 -101316 -104067 -103142 -102035 -99358 -100153 -99491 -97160 -99871 -100671 -100912 -103503 -106110 -107876 -107530 -109525 -110689 -110176 -108845 -108132 -106295 -108794 -109946 -107770 -109576 -112165 -113830 -112597 -114843 -116170 -113189 -113438 -110616 -109591 -111700 -109748 -110452 -109994 -107434 -109133 -107491 -106228 -105058 -107913 -106624 -103782 -104563 -106310 -104692 -104814 -104868 -107385 -106965 -108481 -111477 -109759 -109942 -109228 -109119 -107765 -109648 -107540 -107244 -108965 -108632 -108320 -108390 -107641 -104850 -106893 -104235 -105444 -103776 -101602 -102634 -105605 -106247 -106080 -108581 -111206 -110885 -109877 -109446 -111549 -111374 -111725 -109821 -111316 -108616 -110110 -107467 -110000 -107578 -104634 -106293 -105430 -103029 -105981 -105534 -104730 -103626 -106386 -103781 -103533 -100801 -98848 -101637 -102246 -100127 -102559 -101736 -100123 -98918 -101076 -98192 -100380 -102355 -102704 -103927 -104151 -103318 -105695 -103358 -100456 -98784 -98846 -96031 -94732 -96754 -98530 -98260 -95606 -96403 -94696 -97441 -100293 -101552 -104001 -103992 -103093 -102368 -105139 -106893 -105324 -107137 -107076 -104863 -105508 -106576 -108331 -108908 -106329 -104635 -101661 -103755 -104980 -107398 -108428 -110480 -109201 -111893 -112168 -109884 -112211 -112808 -110570 -112007 -111330 -114285 -115154 -113971 -112479 -109763 -110099 -111437 -113847 -113275 -114466 -116857 -119835 -118512 -115833 -114790 -114075 -117002 -114361 -116477 -113494 -110655 -113268 -112226 -114697 -115508 -116192 -114742 -112806 -114904 -117232 -118147 -120886 -121896 -121598 -123423 -125730 -126746 -125987 -126872 -128028 -130339 -127593 -130480 -131550 -129451 -127873 -130647 -130942 -130344 -131974 -130556 -130533 -127734 -130275 -127600 -126137 -126619 -125427 -123852 -125429 -126458 -126052 -125527 -125280 -125125 -125849 -124241 -123924 -126730 -126107 -128250 -129705 -132299 -129483 -131104 -132109 -131457 -128989 -127377 -128875 -127052 -126202 -126891 -124213 -124411 -122440 -122251 -122466 -121158 -123797 -124307 -121934 -121954 -120880 -122283 -123581 -125161 -123432 -125554 -124879 -122126 -122712 -121286 -119696 -122030 -124354 -124515 -126088 -128585 -126320 -124988 -124932 -123163 -120974 -122877 -125005 -124222 -123512 -121468 -120730 -119952 -117486 -115471 -116251 -115345 -115819 -115415 -117316 -116185 -114399 -112189 -109932 -111603 -112732 -113184 -112131 -109582 -112305 -110287 -110684 -112477 -114833 -112967 -112622 -113453 -115516 -113629 -110977 -113493 -113155 -112879 -111345 -109802 -109373 -112302 -113771 -113159 -110805 -108078 -108243 -109980 -110401 -112625 -110250 -108192 -108386 -107573 -107858 -107997 -105779 -104744 -102336 -103094 -100753 -100641 -102060 -104823 -105985 -105838 -103671 -100991 -98067 -96509 -93599 -93047 -90566 -92043 -93870 -96723 -97281 -97714 -96963 -94610 -97527 -95975 -94649 -93034 -91161 -93029 -93183 -95727 -93348 -92351 -92284 -89916 -91272 -89412 -91221 -89476 -86655 -88850 -88239 -86368 -87565 -87414 -86486 -86279 -87625 -84652 -85022 -85149 -86637 -85586 -88284 -87780 -86761 -88399 -89633 -87898 -88123 -89167 -87247 -87916 -89981 -90514 -93396 -94960 -96016 -95242 -95238 -97590 -97677 -100595 -101709 -102723 -102324 -104638 -102293 -103387 -101286 -98786 -100162 -101953 -100941 -99948 -100859 -101215 -98345 -100768 -99885 -101866 -103274 -101979 -99763 -98157 -97678 -97396 -100114 -100986 -98230 -98653 -99523 -97466 -99961 -97769 -99424 -101503 -103397 -101297 -102378 -102288 -104960 -106420 -108263 -111154 -110563 -108359 -108284 -106296 -108839 -107064 -108026 -106504 -106133 -105045 -102913 -100847 -97932 -96715 -94932 -94254 -97098 -96985 -94017 -93450 -96257 -96662 -98284 -100697 -102723 -103210 -101408 -102322 -103053 -100423 -99431 -98314 -98378 -98145 -100001 -99117 -97832 -98206 -96274 -98017 -97777 -99809 -101257 -100234 -97617 -99799 -100722 -99331 -97805 -95674 -96111 -93478 -94355 -97001 -98474 -98858 -99791 -98292 -97048 -98175 -97655 -96773 -94349 -96739 -99290 -101706 -101093 -98820 -97424 -94941 -94068 -95666 -94881 -94479 -93608 -92369 -92241 -93594 -94170 -94618 -93138 -95347 -97294 -95580 -97399 -97388 -97146 -99170 -97422 -98831 -101524 -101441 -103634 -104361 -106814 -105659 -107529 -106178 -103552 -101497 -98722 -96551 -94644 -95392 -97231 -100197 -102064 -101112 -100362 -97919 -98357 -100975 -101131 -102388 -105286 -107160 -105762 -103146 -100515 -98488 -101194 -102530 -101774 -100679 -99029 -96253 -95052 -97255 -98286 -101115 -102297 -102089 -101149 -99267 -101771 -100350 -102375 -100246 -101354 -100048 -101650 -99918 -98881 -98128 -95632 -97616 -96804 -95151 -92934 -91201 -89672 -88025 -88663 -89004 -88138 -88219 -85756 -83877 -85160 -86677 -86485 -83892 -82620 -84984 -87170 -87638 -87005 -85141 -82996 -82128 -80121 -81659 -83675 -83612 -85124 -84493 -86081 -88201 -89160 -86570 -84798 -87375 -88472 -90293 -88245 -90520 -92903 -94113 -97024 -97354 -97495 -100220 -99248 -97050 -96461 -96597 -93632 -92725 -91971 -89937 -92178 -89607 -86674 -86038 -87322 -84529 -83378 -84975 -82563 -84867 -85161 -85905 -87869 -85639 -87468 -87499 -89423 -91414 -89828 -89255 -89696 -91141 -91247 -90495 -92916 -90752 -90645 -87971 -86606 -85355 -87736 -86422 -89214 -88733 -87072 -87665 -86325 -86583 -85523 -83947 -83391 -85972 -86160 -83730 -85826 -84289 -82700 -80976 -78391 -77932 -77020 -79109 -80525 -80299 -79438 -77320 -76338 -75052 -75587 -77002 -74326 -77160 -79707 -78989 -80183 -83146 -85448 -83684 -82469 -81747 -80422 -79841 -78768 -76733 -77311 -77314 -76458 -74888 -72691 -71854 -71977 -70492 -68058 -65599 -64071 -63075 -64116 -61777 -63662 -64087 -61936 -61508 -62399 -64618 -66329 -65189 -67659 -69604 -71710 -73225 -72832 -75558 -77743 -78967 -78675 -78761 -81589 -82579 -79731 -78272 -80689 -81693 -79173 -77869 -78069 -77730 -76018 -77171 -76752 -78493 -80281 -80583 -78157 -78951 -81280 -79967 -80518 -82992 -85759 -86429 -85430 -84954 -83193 -81412 -81215 -80214 -82155 -82415 -83279 -80829 -83223 -81249 -83649 -84656 -84919 -86169 -88435 -85680 -84938 -81984 -82993 -81697 -83143 -83462 -83522 -82786 -83483 -84256 -85178 -84621 -85571 -84181 -83240 -83081 -81562 -81950 -84764 -83138 -80321 -80567 -82345 -81753 -80796 -81881 -82770 -79838 -80733 -83088 -82117 -82562 -82557 -81695 -84575 -87322 -85313 -86103 -84471 -85703 -86189 -87317 -88678 -88534 -90970 -88170 -86259 -88887 -87207 -87252 -87882 -87714 -85176 -82703 -84227 -82957 -81370 -82875 -80998 -79305 -77184 -78675 -77510 -76124 -76452 -73494 -75647 -78258 -75327 -75642 -75820 -74743 -72131 -69391 -71927 -73120 -72851 -70905 -69986 -70096 -71194 -73463 -74820 -77430 -79806 -82363 -83672 -83481 -81160 -80653 -80767 -79368 -81198 -83260 -84245 -82564 -85458 -86227 -83856 -81330 -78611 -79416 -82075 -80588 -79023 -79644 -77531 -78865 -75905 -74264 -74129 -71861 -70600 -72757 -74604 -77539 -79718 -76788 -76657 -77067 -79159 -79893 -79943 -79090 -77045 -77864 -77655 -76274 -73978 -73536 -75501 -75529 -73913 -75012 -76860 -75101 -72115 -69966 -67019 -66693 -67414 -67338 -66446 -65669 -66731', 'Not jolly
Jolly
Not jolly
Not jolly
Jolly
Jolly
Not jolly
Jolly
Jolly
Not jolly
Jolly
Not jolly
Jolly', '10 15 7 2 -1 1 -6 0 9 8 12
10 15 7 2 -1 1 -6 0 5 6 10
10 10 9 3 8 -3 -10 9 -4 -9 8
20 1 12 3 16 33 41 47 40 44 39 54 42 41 39 49 68 52 70 84 87
20 -16 -17 -15 -18 -22 -17 -23 -30 -22 -13 -3 8 -4 9 23 38 22 5 -13 6
20 -4 7 9 1 19 11 -11 13 17 -7 -18 -16 -15 -15 6 -17 15 -11 13 -17
2 1 2
2 4 4
30 18 17 15 12 8 3 -3 4 -4 5 -5 6 -6 7 -7 8 -8 9 -9 10 -10 11 -11 12 -12 13 -13 14 -14 15
30 12 -3 -1 25 5 -3 26 19 1 -16 9 -2 7 2 -10 -4 -1 0 -10 17 13 -3 21 -7 16 -6 7 -12 2 -19
30 -1 -24 26 -1 -24 15 26 18 1 10 28 -21 -12 -17 27 25 -18 -21 -30 -27 1 22 -21 15 -5 -13 6 5 28 12
3000 7 -92 -2750 -3010 -3279 -2341 202 -2601 -3024 -1977 -1761 -4503 -6376 -9333 -6501 -5326 -6077 -6434 -5627 -2662 -5073 -3533 -2123 -4686 -6103 -4927 -6424 -8846 -10860 -13813 -15271 -13097 -12218 -10833 -11103 -12174 -14451 -13174 -13094 -11936 -11347 -12389 -11809 -11275 -9208 -11175 -10080 -8853 -6436 -5358 -5181 -6022 -4881 -6215 -5344 -5602 -7923 -5191 -6785 -6955 -7454 -6458 -7089 -9154 -7490 -7892 -5287 -4754 -6612 -6142 -3393 -1499 -2923 -5330 -4753 -7623 -8514 -6667 -6118 -8928 -11550 -12440 -11829 -13336 -13449 -10743 -11016 -9238 -9407 -6994 -6136 -3813 -5818 -5561 -6168 -5852 -5088 -6161 -8672 -10427 -9770 -7321 -6568 -7296 -9285 -10240 -7867 -10479 -12973 -15092 -17366 -18121 -18199 -18559 -18737 -20673 -20143 -20363 -21345 -20097 -20737 -19017 -18442 -17736 -17260 -14912 -12903 -14346 -13454 -14269 -17154 -15012 -14126 -14516 -14927 -15340 -12833 -13127 -15377 -12962 -12315 -10073 -7834 -10178 -8715 -6513 -4132 -4119 -6237 -4951 -6007 -4989 -5818 -7119 -8619 -10281 -10933 -11559 -11909 -12262 -9841 -9623 -8623 -8878 -6816 -8659 -7600 -8064 -10298 -12862 -11679 -9219 -7856 -8244 -9426 -9365 -6698 -6842 -6617 -7668 -8712 -10060 -10408 -12546 -12635 -12691 -11552 -10115 -10830 -12159 -9591 -11899 -8993 -11498 -8671 -6101 -4435 -4800 -3157 -3243 -1216 -444 2414 1927 -1040 1050 -1078 -2914 -1240 -410 -1864 191 2123 4204 2727 4394 4757 5043 2571 299 2205 3875 3943 1586 601 1110 536 131 2524 4742 6660 6770 8408 7400 8777 8289 9586 11570 12042 11688 8988 6985 4456 2683 -111 -2791 -2799 -5623 -8104 -8383 -9925 -8937 -10451 -10104 -9740 -6812 -8129 -10484 -10728 -12340 -10712 -8431 -8364 -9928 -11307 -12436 -13568 -15319 -12369 -9510 -10659 -10418 -12494 -14183 -13320 -10406 -11056 -13886 -11618 -9631 -7871 -6026 -6165 -5278 -2569 -2955 -2207 -2459 -3747 -3360 -1133 -3732 -4013 -3256 -5538 -6434 -7769 -9696 -6834 -4393 -3457 -4092 -6007 -3654 -4428 -1797 -2529 324 1353 14 -2093 -850 -583 -1222 -3349 -4459 -3576 -4683 -6241 -4639 -3308 -468 -1252 -1298 -337 1733 2837 959 -932 777 -470 -431 2537 1728 2625 2572 3808 3474 2232 3929 5611 2796 2961 5384 6309 6624 6886 8074 9974 12589 10233 10589 12130 15063 13452 11322 13043 15504 14028 13607 12117 9317 10156 9704 8933 8147 10295 8454 9479 10855 13757 12675 10619 9653 12492 15213 14128 14765 14793 16368 17077 17454 19973 21099 18760 17574 16096 17633 16089 15114 17833 18923 20531 19275 22061 22369 19696 17491 16998 18628 19389 16416 19058 16684 18110 16222 16141 14830 15044 12758 12441 15199 12665 10643 11858 12291 12715 15385 15455 12919 14507 16962 16039 18938 19736 21659 21714 23949 26661 25057 25867 24282 25967 23571 23278 24513 24953 26855 29104 28784 31456 29935 30836 30784 33450 32239 33908 33314 34038 31143 29139 26494 24949 22308 20047 22043 24125 21497 21509 23014 25679 23054 21960 23999 26694 26153 28651 27582 26280 24086 25090 22305 22499 23905 23885 25177 24341 23932 24919 27731 25753 25743 25684 24510 26673 25930 23730 23238 25268 26610 25359 25785 28001 28563 26668 28685 31213 33941 36634 36906 36219 38810 37593 35591 37649 34655 31813 29891 30764 28822 29880 31709 29953 27581 25683 26722 24251 21576 21488 24294 23263 24552 26921 26712 27174 27928 26566 25348 26411 23504 23822 21569 22670 25566 25522 24080 24240 27128 24935 22409 24475 23489 25540 27389 28698 28193 28871 31753 30893 30922 32386 30176 28939 26951 24084 22752 22371 20376 20292 18407 21322 23751 22060 23203 22675 25106 26541 26209 28977 27443 27877 29684 30967 30748 29461 27592 27858 26406 27905 28214 29782 31572 29680 28147 26531 27652 25365 27140 29954 27687 27781 26463 29215 27260 29439 26888 25953 26295 27714 26545 27062 27803 26840 29249 27387 27699 30045 29052 30949 28432 26143 27069 27546 28776 28801 26262 27139 25402 25568 27613 27747 25446 24358 27244 25860 28166 25775 27514 26516 29280 31423 28438 28064 29872 28626 25935 28613 30913 32544 30866 30916 33425 34169 34428 33892 31747 32225 33925 31076 31172 28901 28605 26911 28204 26303 27019 24335 24101 22979 23225 25047 27058 26456 27159 28419 29741 27576 29043 27486 27335 28385 29630 26721 25228 27631 29535 29854 26902 25524 27125 27722 25404 23350 23198 23341 22168 21884 23694 24713 23580 26142 25283 26344 27291 26800 27632 27448 27480 24689 25716 24260 24360 22274 21992 20628 22911 20422 21560 18601 17824 18795 16770 19322 19561 17904 16821 17469 20412 17825 15819 14762 15606 12880 12367 11054 8287 9910 11928 12450 12044 9702 11968 10201 11051 8070 7966 7029 6844 6658 4859 6618 6063 5750 6458 7561 8385 9797 7960 7769 7218 8477 9181 7149 8383 5943 5708 6393 6541 8051 8784 9650 9213 10141 7771 5449 7202 6704 7834 5183 7467 9045 10284 9459 9970 10633 11826 10001 12230 10844 13359 13133 12442 15329 16361 18779 18081 21020 18358 16338 16950 14234 12052 11273 10918 9591 9836 11972 14735 16743 17173 17340 16946 16483 16480 16153 13699 14326 11900 12183 10013 8902 11880 10089 10332 10767 9397 9167 7297 5422 3785 855 1618 1170 -1592 1014 2402 4149 6657 7853 6120 5752 5093 2353 5285 8081 5894 3850 4277 2122 651 -375 395 -2499 -1946 -1209 997 918 626 3467 4724 4757 5677 7503 5312 6246 6793 6173 5338 2457 3942 984 2234 255 1771 -862 282 1961 4530 5225 7558 6023 6060 7572 7510 7602 7128 9189 9091 9238 9528 7886 9536 11284 12415 9654 11852 10348 10135 10707 8590 10889 10872 9307 11226 11529 8786 11393 12944 11765 14193 16009 14847 16875 14030 15386 16504 15073 17629 17375 19828 18207 20930 18562 15808 17674 20314 21890 23388 24980 27086 27898 30258 32754 35510 35239 35326 34601 34563 33586 32228 32374 31430 29894 29876 28455 29274 26363 27267 27338 24540 22163 21352 23353 25854 25328 26935 28335 26540 28384 30982 28348 27063 25361 22437 20004 22247 20656 21598 21923 23618 24383 26777 28350 30917 30503 33088 34765 34609 35867 34916 34718 37707 37908 36653 38239 35924 33020 33982 31536 31472 34076 34233 33857 34403 37147 35779 33554 30676 29123 31267 31420 34022 31307 33178 31016 31989 31260 28816 25819 28790 31004 32017 32719 31272 28802 30719 30574 27891 28014 26211 26877 27521 25848 26902 26333 28052 29104 30651 29681 28646 30400 30237 30172 30695 30922 31474 32823 32373 34139 34907 35217 37357 36230 37342 34404 35326 37403 37010 39337 37767 37762 35810 35634 33342 30906 32030 33102 30929 28818 26738 28465 30237 31925 31626 32017 32040 34470 33988 32173 30642 31043 30582 27703 29527 31820 33675 31093 32025 32930 33325 33316 30828 33784 32480 31097 28441 26667 25187 26812 27440 25871 25713 28544 31444 32017 30860 33570 34413 37306 38478 38890 36403 35029 34936 32365 32142 34620 34102 35621 36577 34467 34295 31490 32190 31097 33706 31795 33197 33563 32763 35247 37760 37563 35299 34969 35816 36347 37779 35041 37441 39362 37338 34759 36053 36075 33970 35756 34565 35554 34377 36529 38293 40116 37308 34792 37292 35742 34248 32894 30935 31963 33397 33572 32871 29902 27685 25737 27605 27639 25963 23547 22673 22228 23066 22279 19605 17181 19757 21149 21699 19261 20459 21684 23661 21916 22771 23002 25567 23180 21909 23723 24139 26021 27297 28528 27365 28398 30191 31186 28573 30821 29516 30247 29876 29407 31440 32585 33860 33376 34576 34504 35217 34391 34835 32900 33770 35838 36671 36994 37687 39469 40461 41535 40015 40808 38669 37336 38615 35951 34836 36885 36487 34496 33556 34123 34642 35643 33245 34970 36171 33414 34220 32709 35457 34070 34869 37608 38508 35687 33705 31918 31861 34490 31544 29181 30604 32826 33776 32653 30108 29374 32081 29895 27412 25343 24758 23053 25692 28479 25889 23187 21019 22520 20887 21479 23435 21647 19264 16430 19223 20935 19130 16351 18909 18612 17631 20254 23037 21466 20067 17620 18372 17150 19582 19789 18988 21932 24121 24607 26370 23680 24664 23876 24323 21501 23321 21067 20350 19560 19156 18110 21097 20549 19932 17016 15950 17664 17078 16126 13236 14745 13262 14457 16690 15712 15241 15696 17286 16283 18412 19582 20484 19896 22018 24807 26754 24574 23163 22914 21485 21562 24182 21909 21580 24340 25196 23400 25714 22989 23153 20262 19889 19816 20392 22927 21183 24060 23039 21221 22587 23758 24022 21742 23554 23332 24484 24095 24478 22970 24741 26179 26681 25000 22090 23704 24769 23948 23189 23094 25563 27746 27619 26252 24218 22468 20264 22786 20921 22191 19469 19329 20994 22267 21987 21709 18917 20232 17673 15339 12802 12813 14554 14573 16774 14050 14795 16927 18299 16354 15698 14149 12837 11669 9178 8697 11183 12921 11225 13225 13435 15901 17809 18498 18260 19734 21352 20759 21400 20102 19285 17450 16501 17804 20517 18226 18829 18494 19089 21130 23122 24182 24343 23904 21133 24112 25457 26111 26682 26897 26680 24099 25676 28355 31172 32195 32193 30841 30958 31316 28986 30085 28202 28899 31701 32230 29417 26648 25420 22804 22019 21682 20359 23334 22403 22886 24621 25348 27407 24922 24241 22388 20485 22639 25380 23947 26606 29495 31543 32567 31287 29059 26999 28021 27568 30154 32519 33863 32433 33253 35500 33238 32807 32458 35084 33378 33454 32766 30404 30986 28125 25720 24157 22891 25756 24488 23063 20587 21229 22183 20239 17984 20907 21401 21860 20447 21797 23661 23853 24320 22807 22415 21196 23405 24056 22594 22818 21296 21883 22001 20070 22624 20326 20024 18825 17115 18384 18804 18797 21146 23327 22766 20233 17297 18238 20295 19725 17924 16276 19005 16905 19454 21394 22377 20922 19735 17846 16965 16322 16011 16630 19148 16366 14393 13723 13178 14478 13121 12821 10778 9438 9257 10940 9504 7899 9558 6637 6607 8903 11102 8667 9975 11501 9400 11029 8857 5887 6551 4587 7131 8839 6366 4514 5490 3692 5258 3952 3149 1527 2750 5622 7737 8622 5918 6403 8030 8226 6298 8898 6685 6961 4049 3690 5726 7766 5068 5974 6712 8816 8154 8237 7272 8763 8575 5670 5327 8291 5465 3351 2270 3857 1528 2605 1575 -519 -2495 -1827 -1443 -1061 1036 240 473 3395 4602 1832 1051 3788 4634 4745 3354 5443 6540 4173 4179 3013 4333 2213 1346 4141 1810 629 -1424 4 2499 1619 -856 914 -1661 -612 -1196 -2692 -2737 -5062 -5645 -6533 -5998 -6449 -7529 -8998 -9193 -9803 -7878 -6914 -7393 -4935 -6958 -9498 -8032 -7360 -9824 -11981 -10765 -9615 -11531 -14286 -16889 -15883 -15862 -13798 -16745 -16221 -14075 -15426 -13040 -15967 -15064 -14654 -13840 -15602 -15660 -14457 -16776 -19738 -22510 -21543 -20498 -20407 -18846 -17148 -14208 -12557 -14745 -14185 -13731 -11034 -12967 -10557 -9897 -8821 -6384 -5779 -6515 -5919 -5829 -5515 -3289 -6153 -3957 -3328 -657 -1881 -4601 -2063 545 1111 2961 5805 8742 7000 6869 9483 11833 14479 13984 12688 13318 13834 12260 15248 17979 16785 18934 21553 22264 24000 22087 24772 27329 25723 24088 25920 24311 21787 22644 23062 25426 26398 26338 25615 22739 25729 27138 27010 25696 28476 25657 27973 27545 29513 31783 34040 31967 32135 30201 31100 28413 30062 32114 32894 33809 31451 33405 32124 30735 27988 27180 29810 31451 31160 31505 28513 29305 32106 33661 34770 35439 36843 37837 39217 40676 39901 40103 38028 40057 43029 41405 43670 44283 46964 45312 43481 41507 41129 39272 36420 36657 33765 33094 35795 33140 35899 36372 35365 32510 29667 30992 29281 27454 28905 28448 27356 29346 31143 29836 28857 30826 32812 31486 29439 27936 26739 24498 25500 27294 28952 31651 34172 37007 36123 34407 34712 35293 37144 39550 36918 37842 37236 38851 41475 40563 43434 44323 45639 47363 47110 48727 46422 48583 45732 48098 48654 51186 52303 54539 55849 55912 56416 54753 57129 55034 53488 54766 54404 52686 53948 52400 52067 52981 55376 57030 57709 57422 57476 57436 55110 53430 51696 53330 53055 53181 55965 55044 54047 53811 54236 56433 53806 51669 54345 57096 55209 55329 55943 55244 55073 56455 54240 56660 55176 55943 57789 59629 58618 60743 58584 60177 62137 62163 65162 65463 64307 63078 66055 63836 66303 66197 66798 69100 67480 68686 67018 64926 64244 65599 66589 66174 67680 65571 64281 62836 65292 63803 64846 64001 65056 67906 66093 63483 63882 65781 66399 68031 67357 64807 66750 64619 63484 61458 59931 62343 64727 67247 66982 65778 64927 64281 66251 67597 68379 68403 68583 69405 67297 67974 65271 64155 65308 63565 64732 64595 66371 64275 65422 63044 63541 64044 65604 63855 63486 66472 64732 63716 63273 61263 60037 61226 63239 64277 66565 66950 64838 62630 65112 65126 67764 65103 65107 65240 66104 67865 65781 67905 70806 67949 69134 69085 67144 67819 69988 71513 71618 74438 71979 74064 76080 75995 73004 71195 71526 69099 69952 70453 72910 75142 75370 72372 70924 71466 69403 68458 66943 66970 67331 69303 70119 68041 70353 70468 68522 68619 68111 69402 66977 64602 66792 69023 69321 67425 65146 64237 66274 65034 64054 66937 67693 68554 71102 69838 71985 72495 75203 74942 77321 78762 76189 75567 72585 72921 70754 68579 70544 72903 73462 75152 77359 80003 82964 84520 86299 84894 84762 82310 83737 86326 83609 83173 81820 83417 80652 80545 78381 80127 81286 80418 81249 78450 77740 78780 77250 78957 77487 76727 77099 75752 74223 75616 75475 75427 75463 76229 75451 72783 69828 69629 72558 73433 74823 73131 72891 75418 73931 73113 75204 77586 79241 78009 80187 80234 80641 82988 83150 81756 78831 76968 77176 79578 79652 77015 78574 78912 79602 81423 80640 83030 80034 82210 80621 78232 78865 81140 80680 82679 81035 79960 82190 80260 80049 80614 81094 83783 85631 84270 83050 85896 83185 82455 82835 80658 83556 84877 85352 84480 85701 88437 86653 89152 87181 84958 85973 83356 84283 87111 89934 87021 85368 85806 84367 84560 82284 79706 81159 79161 76560 76459 76170 73507 71749 73707 76555 79336 80992 80876 80227 77533 74700 72175 72811 75210 72878 75762 75070 72949 73865 71853 70955 70346 72541 74080 76324 79284 79725 78344 76746 77573 78687 79031 79319 77196 75831 78202 81071 78777 77778 79491 80238 77658 75037 75139 73744 71725 69260 70841 69500 67670 68136 67203 67358 68023 70525 71844 73698 71805 73208 70950 71549 68713 71243 68646 70292 72131 73079 74692 72433 70262 68342 70990 71748 71028 68255 69334 67894 69396 69314 69299 70878 71110 71269 73520 71540 69901 70820 67854 65282 67324 67473 66935 65206 67289 67611 65080 66884 68841 67912 65649 64581 65618 68300 67160 64483 65115 67833 66068 68965 67084 65090 62766 62223 61556 64363 66465 67925 65065 67933 68629 67910 65462 64908 62873 65689 68423 69904 72564 70567 72347 73073 75380 75708 73836 75080 77891 75582 73254 71412 68759 65955 66749 64270 65450 63574 60886 62214 64677 62511 64296 61522 59791 60312 62549 61855 64684 66988 65150 64775 63688 62635 62743 60602 60202 62086 64184 62305 60084 58512 59714 61675 62695 62091 61955 62795 62026 64971 62978 63827 66484 68068 67856 68259 70352 72612 70261 68174 66844 67935 68726 71310 71424 72844 72537 72263 73349 73861 75156 75403 77556 78561 79815 80663 78756 79747 77621 80307 79684 78089 78912 81838 83989 83432 84975 85394 83191 81668 83118 80807 79546 79176 76268 73450 71667 70554 70400 72047 71522 70579 72294 72345 69470 69435 67991 65201 64603 63189 61937 61284 59467 58678 58352 57731 55792 53990 55975 57594 58428 56551 59469 61747 63710 65293 65467 66476 67330 70065 72153 72659 74331 73723 76640 78368 81248 80070 78237 80534 79285 80498 78460 78183 78434 77309 74446 73147 72039 69989 67013 68382 68177 68950 71930 70533 71786 70581 69340 71791 69719 68635 67928 69212 70107 70745 70935 69868 69977 69398 71609 72209 73616 76413 74193 75773 73435 71031 71173 71429 73289 75686 77878 77223 76919 75735 75208 74524 71950 71418 68863 66117 69101 70163 68788 68967 70113 69818 71951 69590 71725 73457 75009 76169 74720 72132 74467 71901 72698 71688 69738 68526 68984 67850 68626 67462 69930 71036 71914 74664 73869 74527 77352 74369 71865 72015 71425 73972 76621 79174 77682 76144 76760 78588 80514 80395 80935 79026 76612 76116 76467 77188 78661 76437 77151 74200 71412 71428 72297 74103 75199 75241 73784 74691 77345 79784 82453 81914 80318 82761 85599 88182 86736 85777 85162 87374 88327 87225 84824 84144 83471 81787 79151 78722 80589 79322 78168 80674 82377 85250 85884 87835 86142 86679 89176 88348 85353 86058 85568 87285 90141 92051 89116 88538 91316 92066 89554 92485 90997 88436 86507 86915 88667 90936 91500 88747 90818 93159 93037 92691 92226 94521 92555 93619 95181 95364 94245 92264 92512 93977 91931 93868 96124 95311 95826 98146 100449 97475 96789 96226 97808 97003 97547 94693 95072 97562 98284 97315 100234 102390 100968 103478 101503 102998 100035 97489 99563 100365 102906 103044 102978 104349 103881 104855 104503 102777 104301 105900 108834 109764 108366 106763 107331 105531 106601 108390 110251 108135 106797 107765 106422 107184 107902 105617 103916 102148 101880 101141 103759 105516 107161 107049 109389 112198 113334 115021 113116 114588 115870 113227 114642 115233 116423 117285 119673 118990 118650 120540 121165 123857 123401 122666 121649 124598 121853 121514 123859 121084 123607 122211 122923 123669 126610 128071 129731 129558 129316 128576 126545 124395 122043 123902 125310 126324 128236 130728 130685 128702 128335 127377 126438 125175 123295 123170 122724 120625 120319 118615 119988 120430 121282 123004 120511 122695 124935 125010 127657 129842 132477 132607 131559 130084 130584 129442 128600 128782 131434 131634 128787 126342 126831 129423 130383 127823 130303 132463 133931 134194 131291 129681 129005 126902 129256 127984 128726 127308 129323 131261 133991 134423 135941 136835 136631 138354 139388 141302 144139 144018 144342 142941 144041 142415 141507 139190 140295 140364 140405 137902 138820 136510 137702 139655 142249 140574 138124 140461 142295 143823 146113 149055 147847 148758 150429 149220 149117 151579 149630 148720 146990 145835 144707 143347 141340 143814 145625 146637 149557 150831 151345 150825 149592 151478 149999 147761 148183 149844 146851 146530 146343 144562 146129 143687 144563 143349 145960 147492 150085 150288 150517 149872 152467 154625 152848 155625 155501 152635 152011 149306 152002 153484 155827 153094 152257 151508 153108 155704 158017 159503 157026 158666 158697 160553 160268 161225 162994 163501 162177 163863 166199 167991 165572 163873 164094 163212 162551 159775 158686 159847 157333 158226 156961 155037 154001 154918 157310 159690 160494 159374 157129 157264 158900 161152 161358 158484 161026 161367 164321 163083 164220 162107 164684 165832 164416 166550 164304 165217 162783 162972 163421 165829 167165 168984 168983 171697 171947 170796 170238 169073 168208 165260 168026 170047 168949 169078 169474 167395 166449 167490 167093 165883 168610 166736 169121 166471 168433 169987 171346 172863 171526 171109
3000 -1604 -2878 2043 -1241 -2118 -1446 276 -1991 -1322 -2346 669 859 145 1204 -198 -2066 33 -1638 1186 -2804 -822 -59 -699 -1461 -317 1722 2482 530 -2082 1034 -148 2299 2575 -53 627 -415 1773 -2763 -2449 437 -2680 -2962 -1355 468 2552 -2833 -937 -2407 1481 1819 2944 1514 -2053 940 -967 1576 2862 1459 -2056 2871 -2600 -2018 2899 2626 1190 -1527 923 1334 -2472 1578 -2065 2965 564 29 2736 2387 910 -2374 -2751 -684 -2790 -2447 1504 -1504 -2822 2315 1993 -2052 2249 -1314 -933 -873 -75 2098 160 -2103 2556 2699 1876 -1879 -1537 -1953 1471 -1780 -748 -515 321 108 511 344 578 -876 -1981 -2849 1242 -2597 -54 -2357 2673 -1830 -2458 -1120 357 2585 -1104 -869 1123 -11 -2932 -1803 213 -2119 2676 -2129 -921 -1561 1740 -2462 2773 729 -946 2925 299 2434 -1114 1456 -150 2640 -544 -2686 1594 1898 2815 -875 -356 -784 -2042 -2935 -120 -2724 -2808 -193 -2005 2893 2243 377 -473 -989 125 -2043 641 -2805 -2264 -1119 -2022 -324 -2056 -16 2875 -2706 -1374 395 -2779 1591 -2710 1664 -2180 1239 772 -2380 -921 -89 102 2211 1094 1453 2246 -1784 -1358 -192 -2650 2337 -2038 -1083 2864 1993 -2024 -1719 1606 -888 -48 820 -1205 2372 -1655 1859 -640 -1642 2483 -1614 66 -2256 409 2578 -2321 -222 1397 94 1571 1619 -1987 522 -2468 770 -314 2482 -2515 -1443 1516 2755 -1199 -2940 -2588 -404 1375 -2359 -1569 -1454 1871 -111 1319 -62 2740 784 2444 1913 1270 818 -2731 -2172 1983 83 2879 1779 -1766 -80 -2214 1382 2128 187 23 -2662 -887 1218 294 1526 2287 1137 -1722 2125 -1091 -1585 1724 -544 2223 2524 -2793 151 524 1755 -1738 2406 -1017 -1464 1065 -1826 -226 -2078 -325 2984 -254 1858 1617 2390 1872 -15 -2729 2136 -2708 223 134 448 2806 -423 1090 -2275 -2366 97 -1491 2689 -1560 -1496 -216 1876 1103 -1550 2249 -1355 -1531 772 856 2122 -2637 2685 2544 1791 1676 1261 1128 -240 -1408 2886 1572 329 -1420 -2672 868 2164 1171 783 1702 -266 2240 2991 1517 -137 -2514 -1183 2223 -2844 -888 1387 -576 1828 -319 -778 -541 2518 1649 -819 1400 2512 1754 -2944 2564 2127 -57 2982 -358 1544 1672 -1482 -543 2859 -2476 1821 -2353 -1343 247 870 -937 -1120 1435 2555 -506 -2865 2729 -2764 1306 -249 1973 1859 439 287 -335 -356 -875 -2729 -1104 426 1239 1085 1904 -335 2303 -1848 1540 2802 -1330 1859 2207 535 -2590 -1522 -1748 390 -1427 26 556 2082 609 -1489 155 1281 -946 -2096 -1027 956 1533 -619 -600 -1313 962 -1827 -1756 2460 2801 -991 1738 -55 -1947 1514 2790 2476 1791 -2903 -2517 -799 -1907 760 393 2084 -502 1808 2644 -1668 1361 -1216 1233 -583 -2493 -2698 -2370 -864 763 -55 -831 -2720 -1999 1115 1829 1266 -856 2674 204 907 2077 -2562 -196 316 -248 -843 1837 -2990 1402 -361 2152 -1565 -1423 100 -2774 -736 366 -129 -572 -446 408 -818 756 677 1450 29 2631 -1402 2841 1266 217 2625 -2435 1382 465 1497 1694 1085 -1588 -311 65 315 -1019 263 -2109 -896 -109 -1326 1138 -361 204 1181 750 -2759 -1811 -953 114 1474 502 -636 1468 -2682 1304 397 797 2436 412 -2401 -2966 1014 -1532 860 1506 2405 1875 179 -2015 -2047 -1548 -31 233 -1989 -268 486 -1620 -691 -2897 -1011 -923 -1712 2823 -2466 753 -501 -866 -1236 1625 -2259 1185 -2624 -2879 2333 355 -573 2795 -31 1310 2928 -2892 -1028 -1734 -1940 2816 2562 2155 2761 65 753 -1785 139 2308 1394 -785 564 1021 -1693 2359 -964 1646 -1253 1142 -881 -2939 2933 -1073 -531 2945 -2353 2616 -1091 109 790 733 -415 -101 2396 -2405 613 -1570 -1941 -463 -1869 -1420 -873 -399 2935 1941 2513 -2662 -483 1371 -2264 2227 154 1695 90 99 -1295 2437 1258 -1389 1891 1219 23 -1533 2345 -1762 -2565 -1348 -2865 -1872 -637 1398 37 2571 -1953 -64 -1051 -2718 -1063 2909 759 2384 -1203 895 -960 -2913 1319 -2105 1156 2423 -2510 287 -1859 2105 715 -1172 1711 1402 -1791 71 -372 821 28 -870 -2055 -741 651 1812 -2120 65 217 741 -1010 -1802 2650 2531 -415 -1 2550 1781 -2673 -2111 1780 -1962 347 -379 2420 -2648 370 2239 726 -989 360 685 1777 -2077 -1211 2785 2013 -1040 -520 296 618 2785 -987 -1792 413 -2150 611 1242 1282 -2427 1089 -1915 1704 1141 -2933 1136 -279 -2059 1231 2914 -1252 2510 2107 1254 1420 1675 895 -2461 -601 -2979 2761 -565 -1567 -1021 -2271 1530 1275 722 131 -2189 -700 -2338 595 1243 1337 773 2982 2674 1949 1496 2956 -814 1335 2711 -2787 2823 523 -2744 -245 -1348 586 -2756 2576 -439 -2582 1861 -1239 1012 -890 -672 2313 2164 -126 370 788 1853 -1611 -1418 -287 7 -1627 -2862 -570 -1265 1327 -2202 2217 -57 1628 -1169 -1870 643 85 2453 2886 841 540 220 2293 -726 -1561 -847 -873 -2941 1431 -2757 923 1777 -395 297 -2861 -677 2392 93 -840 2366 -2062 -2950 313 2115 1829 867 -1393 -1870 2051 228 2260 2508 -1326 2470 -2175 1470 1424 -2147 -678 1073 2752 -1557 -2792 -1575 2856 -1497 501 -1700 -1782 2508 -1265 -1689 -1655 -512 2460 2643 8 -417 1971 2378 586 2571 -1044 -597 1217 -245 -118 231 -2032 -1174 -2050 1414 -2469 -961 -1017 -1091 348 -1246 -411 -295 -1778 -707 1556 -872 1684 -827 -2816 2421 -1703 2463 2634 2299 -1384 -2998 738 1244 -1266 1946 -1456 -1264 1147 404 -230 -2304 1385 -2280 -2776 743 -2234 -298 -2237 146 239 2683 2659 313 -1897 2304 -2049 -1438 2206 -169 989 2201 -1894 -2666 421 -2380 2366 897 -1338 1461 -2669 -1848 -97 -2737 421 -49 -1520 1222 -924 -2308 2377 1173 -1818 222 1340 1395 2442 1079 1584 2959 2765 -2335 1263 2538 -148 1585 -1930 2886 2627 -1509 -642 790 1591 1604 -846 -2153 1922 -2154 905 -2158 2359 1433 2700 -1797 -934 2662 -2046 1427 -2136 -938 -751 -753 -358 -1775 168 670 1002 -568 1235 1131 -332 -2214 695 -2186 -2352 -290 1234 139 2762 227 -1659 1647 2512 1081 2954 -1393 -655 -1743 42 -187 76 2790 1820 -2862 1167 -576 2444 -93 -2590 -2985 -1827 -2983 67 327 -599 337 -1960 -832 1250 -1872 -2585 1298 -2279 -34 -2778 1920 -2605 41 -2894 -2776 825 245 -50 -2541 -499 830 2281 375 -604 1387 -1426 -2764 2136 303 -450 1844 2950 -1658 -1376 1939 -2287 -586 1152 -928 -1504 2648 1887 -2841 2765 -203 -1398 475 -643 1518 -1368 -2963 841 -1829 1933 -2446 17 -2374 511 2318 2710 -1274 -789 280 -179 267 -1199 -1579 -79 -1590 2380 -1832 -1041 -804 -2747 -501 167 -934 -1129 -1348 1078 1614 -2529 -2890 -2261 100 198 1998 -1116 2837 -2506 2203 -2203 826 376 -271 1418 -1414 -1964 -2866 1930 -2020 -1191 1418 2874 1171 -121 878 1899 -1998 2806 -2375 -1990 2462 407 -1406 -2052 -2239 1331 2934 -1104 -1738 2993 2925 -1273 2532 -265 2983 2732 329 -1578 -2221 -1893 -980 -2023 -148 -622 -919 -2601 1184 -2969 -2543 2564 1978 1052 1683 1454 1780 247 2359 -2948 2770 1251 -1813 1680 -2397 2390 -1233 1325 -1606 -2774 2506 -402 2235 -2347 -1406 -527 2276 -2122 -1438 -1503 -1443 2206 -1191 -2355 -1808 -2656 -925 -1657 2475 164 -1967 -1486 1319 -1003 -1730 1593 -2322 2838 -2746 -711 482 -449 1524 1397 -985 -586 -1390 -848 -1870 1499 -1523 -940 956 -2498 2523 1485 1202 -1124 2077 -588 973 2605 2603 -2217 -364 -2605 919 -1129 1286 -1278 423 -1619 61 -2602 -2858 2908 -2545 -1677 -2352 -316 707 1111 -1807 57 -997 1134 -2050 -181 -1921 -1857 2851 -2349 -1529 -1972 2612 -2897 -902 -2735 1984 1039 2911 1032 702 -1633 1287 1521 542 2571 1558 -1321 -1740 -1980 -558 -306 2026 1687 2016 2807 2232 156 2045 -2121 -715 -977 -2782 1499 1539 1977 -1760 -1518 678 1486 -2328 -2899 2312 2017 -2713 2951 -372 -1583 -1461 2104 720 -399 2498 -444 -1127 -553 2023 534 2307 375 2330 582 2145 -1234 -2068 -2257 -1101 -2278 1574 -693 467 365 978 2738 -2874 -1800 -2564 -374 2430 1890 -1281 -505 1309 1855 -1482 3 389 1195 -2597 1118 -648 515 712 -1835 2249 -2461 -1545 2551 935 -1060 1030 1860 2885 2616 -2597 -2929 1289 989 2013 553 10 -1200 -2964 2156 -1747 2372 -2732 2214 1135 -2966 2347 -489 -2281 2845 1399 -2430 813 -1511 2594 -210 258 1160 2455 2451 -2851 1554 -738 -2301 471 -610 -2903 1067 2371 -1257 1956 -2092 -891 1848 2625 365 1450 605 -1420 899 1393 1897 1337 -2272 -1060 2626 2526 2621 -2990 -2339 1468 -2400 -650 -2376 232 -303 1228 -2682 1008 889 -2078 -476 2214 806 -828 -2991 757 -218 -998 -2202 -578 -973 -679 -2008 -115 581 2919 -581 584 -1085 1421 -1611 -1387 -1249 -2192 617 2961 -1949 -1648 2554 -2835 -1537 -1708 -1822 -638 -1787 -2072 2315 2254 2275 1193 -597 -2545 447 2183 -1565 1412 226 1737 75 -178 -2450 -1635 -2261 -2638 2763 162 -1378 -499 1776 2605 1561 -581 136 754 -813 193 -172 647 -771 -2388 -1073 1605 180 1553 49 825 1320 -1910 1075 2678 1285 -435 -2580 2913 -65 2091 -1225 354 -2780 2099 -1727 1667 -2959 -2235 -1458 -2456 -998 2933 2115 1281 2852 2856 1677 1697 -980 -217 2339 -1219 575 2688 2550 -1556 666 451 170 489 -693 1761 -2084 2381 -2938 -1874 -1324 -2879 298 320 2662 -2892 -162 -1610 -2030 243 -1659 2099 821 685 -1152 -1192 -743 -2132 1728 2671 -1010 -604 799 -1283 -167 -1664 1020 -1634 2928 1555 -1715 294 1210 653 2802 -192 -1731 -2225 1174 -2919 910 1433 -1052 2194 -20 -1949 -373 -261 395 -281 2352 1309 -1652 -1951 -1934 445 923 366 -2801 -359 1891 -2043 -2181 837 260 -973 718 -1459 2673 -748 152 1015 2238 534 -2947 1082 1786 2501 -883 -2690 2202 644 -240 -688 624 2561 338 -2496 -160 1830 1501 -2954 966 1365 928 -2369 -461 -2547 -592 -867 -2142 -2216 1728 841 -333 -1739 1417 -2329 -1389 -2808 565 -2073 -296 2194 -2546 -2995 2303 1510 -2135 968 1714 397 -879 -1574 774 119 -2968 64 -1568 1697 -1608 2899 1229 -2694 -2278 2909 -70 -2298 -1887 2391 -1084 815 -1832 2341 -1773 -239 1503 -2086 -2503 1984 666 -973 439 -1385 2596 -2893 2378 -2018 334 -552 -1752 2366 -2800 135 -93 -2015 2349 774 -2738 696 278 -2476 -1002 -647 -2346 -2010 1524 1751 45 -1335 -2633 -1146 2359 490 -2938 -444 109 -2315 -847 -2908 -2817 2330 -2782 -118 1357 231 -2607 2537 638 -618 639 2854 2202 2566 -885 -1668 661 1137 -1098 604 437 -1165 57 -870 -1006 -696 1671 1999 2003 -1195 -1172 2760 1193 1721 -1223 1011 2563 500 -672 -660 -2216 -1590 -1499 -2791 -796 2383 2193 1155 -2406 -2311 -1547 607 -9 -182 -2228 -2236 825 2749 -1697 -699 842 2129 294 -2205 -1505 2637 701 -1434 405 -81 -65 215 1554 -2008 -2935 -564 -1540 1794 -529 2477 -44 -1682 1305 -1200 2243 -1461 2979 1560 -2407 496 -1215 -918 126 -289 -250 -973 1158 -851 -1515 -2770 1551 940 1404 -1934 146 -2240 2252 -2566 -2589 894 -1803 -2215 1790 1389 -2388 1131 1481 825 2950 1197 1075 2319 2345 -42 2711 1150 2122 -109 -2344 -421 -358 -1329 -404 1094 720 1303 1909 355 -74 -1900 -257 -2980 1493 -1319 -2182 2743 1957 -104 1178 -2790 19 987 -1700 2577 1392 2645 -2000 1026 2514 104 2121 -1835 -1317 -2718 -2498 -956 -1839 294 -1534 -464 72 1737 -2404 -1553 1499 1762 -53 -1265 1349 120 -1105 814 1649 2091 1021 1799 1423 -2183 -928 -2487 927 -1027 -2905 -625 996 1898 -2936 -2586 2588 656 -2242 -1487 197 1791 2524 547 1708 2457 -214 -2714 1255 2546 2586 -937 -1971 -1821 2997 2079 -215 1239 2968 -2251 -72 1151 -446 -248 2127 -1094 342 -1807 2549 -1044 2352 -1858 -1279 -2930 -340 -1624 2596 -1025 1261 -2943 -388 1324 -132 -1846 271 2691 890 -2635 -1142 -2738 -912 -1682 2370 280 1135 1635 1803 2834 1396 1493 623 1079 2641 2394 -662 -1893 -1118 -2664 877 -2376 -2984 1091 -2319 -2046 -1133 937 -80 1500 152 -1095 -1395 -841 -722 -1555 -155 2856 1580 1040 -1201 2869 -1636 -2125 953 2047 -1168 816 389 -2589 1881 -697 -1616 2821 105 818 659 688 1399 2675 -1160 2732 675 -1303 -2595 1985 -692 51 -1576 983 2736 -2533 -2973 1180 1456 -2210 -1273 1685 54 184 2390 -1249 -2771 -2959 1602 109 2999 -659 -2680 2562 -416 -2385 1007 -2418 -1996 -448 983 2088 -967 899 462 1091 -2766 -834 245 -405 481 1430 1275 1582 1321 976 2546 -1959 -1006 693 434 2214 2282 -666 -685 -549 1325 2103 -1468 2345 2860 1871 -1911 -1517 1951 2015 2544 -917 -2417 2988 -2126 2078 2254 2168 -1639 -10 1970 -440 -1293 2929 1225 -1734 -1176 87 880 2384 2456 859 1668 -1884 -928 -87 1659 -1750 -2980 -2870 -1497 2578 -101 1301 -1215 806 820 -241 1458 -1506 -482 296 859 -1363 -1554 -2958 2893 -1534 -257 -1444 69 -2383 1452 -142 -400 881 2891 -535 -1842 -2624 1001 81 -940 -1423 -2105 1539 2138 -836 -561 2309 -1178 1799 1187 -2963 -1583 -542 2074 2679 -1187 -419 -661 339 -2202 -270 -307 -2373 2643 -2244 1986 -1317 -1212 1165 -2502 1067 -2058 -680 -433 550 -787 -2555 2671 1337 -343 -969 2747 -875 -1433 409 99 1318 -2905 -460 -1369 1619 -2178 1465 1877 2754 -2296 2044 280 2937 2301 1999 -697 204 -2521 2759 -1170 -2497 2742 -1593 -158 2261 416 2831 -1104 482 1806 -815 -2059 -741 -825 -1223 -608 2446 -378 1342 -514 2543 1929 2972 -131 -206 -2900 -50 302 -2207 2270 -2684 1026 2053 -2378 273 -1558 1721 474 -2715 -2291 -2269 1598 -507 -2843 -2763 1217 1258 1915 699 -702 -2752 -895 2071 521 912 -2838 1242 -1630 -2990 958 934 1825 -2297 -19 -1604 -409 1733 -2034 549 -700 -331 475 -1287 -2760 351 -392 -875 -2229 -204 2633 -1328 -1763 -611 1596 -2757 -2981 -2038 -2009 2997 1280 409 -2968 2224 -193 -351 274 1455 62 -1159 -2252 2036 1414 -266 -2648 -2027 1757 1674 2931 -2340 1279 735 1217 2805 -1623 946 -795 -896 2419 1062 1664 907 368 87 -1696 -2912 -1964 -1561 -2835 -312 -1093 2121 -999 -1200 -538 -1957 1056 2112 2289 2670 -706 1048 -1886 254 1850 -44 1690 1746 -2439 1681 -1516 -1079 2771 308 -1855 -1467 -192 -1447 2532 -1005 1882 2570 -1341 -2738 1252 -347 -657 -1416 1322 2378 934 2565 1725 -1186 920 1345 300 1106 -773 -2037 -630 -2196 -156 -1431 -634 2167 2252 1611 -411 -1017 2153 609 679 -175 -551 519 2506 63 -273 -2427 -2873 999 460 741 -1492 1215 -634 123 2170 -147 1567 -59 -1850 -2364 -1439 -2263 1865 -663 -2662 -1228 1649 -1289 -2707 -1889 941 -2255 1350 -1944 862 -7 1665 -1071 1582 1167 -408 2603 2352 -1202 1334 -1902 1564 -2036 2003 2947 -2729 866 -2619 -287 -2222 -1881 67 -429 -1999 -2344 2501 632 2114 -1539 802 -643 -2531 -48 -2768 2072 -133 -2784 2800 -376 -1898 66 2984 -2086 2508 -2051 -1053 -2619 -1767 -2604 -80 529 2876 405 1020 1250 -2180 -1129 -1125 -2358 1328 -2966 1737 -1136 502 989 -308 2429 2685 -640 381 4 1100 2329 -2991 987 2835 -2292 -2052 2836 -308 -845 -1579 2569 -1268 792 -1358 -1268 -3000 -2153 1060 1342 -1228 -2171 2226 -1355 640 -1730 -1215 2110 1326 -198 -351 -68 257 2983 1774 -2570 -1664 -1681 1390 280 1917 380 2346 -201 -1454 -1680 -2711 1803 1668 -2329 -505 800 -1695 -17 -1250 1291 1410 -775 2255 -1408 2281 2495 2532 1658 -2901 2060 -2006 1077 1619 -2725 -2824 -1992 2846 1796 1465 -349 -69 2678 408 674 -1132 1323 -1824 1409 -2269 802 2364 -624 1980 -2661 167 1189 2554 -1649 -2468 -1375 2531 -94 346 -1669 1792 -550 1099 -2107 -359 -1499 -1487 -706 -891 1228 -2194 -2715 1805 1561 -871 2045 -371 1060 2030 -325 -1546 -109 -2488 -1984 561 1658 2807 -1254 746 -1117 -2647 700 1373 2832 641 1515 2759 293 -76 837 -2417 -902 -2723 392 -1260 1707 -2176 2648 709 176 756 1655 351 2494 -565 -563 2328 -1297 2359 500 555 2490 -2749 -2889 1940 -2816 1283 566 327 1829 -1685 -2576 -721 224 271 79 -2114 -1900 -2301 2652 -1454 2128 -2219 -1090 610 208 -1861 -1284 8 -555 -1313 -1312 -1061 4 2798 -2179 -648 1351 520 -1011 -2880 -2705 1039 -1647 -861 2690 -2203 -1770 149 -466 1481 -1316 603 -2125 -1636 -1885 -414 1890 -414 -662 1579 -1103 589 -294 1812 -15 -1144 -2571 374 2554 684 1601 2568 -255 2030 -1952 -387 2537 -65 1128 -2604 -558 -2435 1342 2537 -816 -634 376 199 1549 2328 -2680 2065 -1633 -2630 -2228 684 -966 -1837 2913 2515 2162 -1140 -2280 368 631 375 -221 -1945 -1667 2386 1384 2555 -2000 568 -369 -678 1378 -2679 -8 2267 -1883 1135 -140 1545 -2275 2488 -844 878 -564 -2106 2166 2796 -247 2578 2800 -427 2553 -2120 -2120 -2300 -2206 753 1101 1138 -948 -2594 2970 -490 2402 2645 1075 1801 1762 2272 2117 -506 -972 -70 2868 2777 -344 1190 1816 39 2730 2334 419 -2013 1431 353 914 -696 -2514 -2971 -2390 -533 2004 2860 -2745 1054 -270 -1488 -2378 72 1085 1823 1332 1873 -1404 2168 2868 -1150 267 -2709 -2084 -2096 836 354 1752 2140 257 1207 1750 -595 -2933 -1444 -904 2035 1591 98 1383 1758 -2234 -2018 -2368 -1879 -523 685 -2185 -484 716 1094 -985 1338 -597 -67 -1703 -2687 -2765 6 2218 1395 -1392 1717 1836 -2063 2660 -75', 'Jolly
Not jolly
Not jolly
Jolly
Jolly
Not jolly
Jolly
Not jolly
Jolly
Jolly
Not jolly
Jolly
Not jolly');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (11, 10041, 'Vito`s family', '10041 - Vito`s family', 'https://onlinejudge.org/external/100/p10041.pdf', 1, '//uva10041
#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
using namespace std;

int main() {
	int n;
	while (cin >> n) {
		for (int i = 0 ; i < n ; i++) {
			int r, tmp, distance = 0;
			vector<int> s;
			cin >> r;
			for (int j = 0 ; j < r ; j++) {
				cin >> tmp;
				s.push_back(tmp);
			}
			sort(s.begin(), s.end());
			int index = s.size() / 2;
			for (int j = 0;j < r;j++) {
				distance += abs(s[j] - s[index]);
			}
			cout << distance << endl;
		}
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '18
2 2 4
3 2 4 6
2 4 2
3 1 8 9
2 3 100
3 1 4 100
4 2 9 12 11
5 2 4 20 4 3
6 1 2 6 5 4 3
7 1 2 3 4 5 6 7
7 20 92 23 239 93 92 283
10 239 2032 2039 2003 939 2039 182 182 182 939
15 28 303 93 93 93 920 12092 932 892 9239 928 127 38 74 2
20 838 2838 2903 39 993 29339 9239 20930 929 929 9028 9239 283 82 2 38 283 76 37 98
30 29 2 39 239 2 3 93 83 283 938 2873 238 83 72 283 273 28382 28 23 838 27 38 48 848 84 848 8282 83 28 38
50 38 38 48 2092 932 892 848 84 848 8282 93 920 1 9239 92 2 3 2 2039 2053 939 26 92 9132 892 848 841 848 2092 932 892 848 84 848 8282 93 920 48 2092 932 892 848 84 848 8282 93 920 1 9239 1
100 26 92 9132 892 848 841 3 34 23 43 38 38 48 2092 932 892 848 84 848 8282 93 920 1 9239 92 2 3 2 2039 2053 939 26 92 9132 892 848 841 848 2092 932 892 848 84 848 8282 93 920 48 2092 932 892 848 84 848 8282 93 920 1 9239 1 29 2 39 239 2 3 93 83 283 938 2873 238 83 72 283 273 28382 28 23 838 27 38 48 848 84 239 2032 2039 2003 939 2039 182 182 182 939 848 8282 83 28 38
200 26 92 9132 892 848 841 3 34 23 43 38 38 48 2092 932 892 848 84 848 8282 93 920 1 9239 92 2 3 2 2039 2053 939 26 92 9132 892 848 841 848 2092 932 892 848 84 848 8282 93 920 48 2092 932 892 848 84 848 8282 93 920 1 9239 1 29 2 29 239 2 3 93 83 283 938 2873 238 83 72 283 273 28382 28 23 838 27 38 58 26 92 9132 892 848 841 3 34 23 43 38 38 48 2092 932 892 848 86 848 8282 93 920 1 9239 92 2 3 2 2039 2053 939 26 92 9132 892 848 841 848 2092 932 892 848 84 848 8282 93 920 48 2092 932 892 848 84 848 8282 93 920 1 9239 3 29 2 39 239 2 3 93 83 283 938 2873 238 83 72 283 273 28382 28 23 838 57 38 48 848 84 239 2032 2039 2003 939 2039 182 182 182 939 848 8282 83 28 36 848 84 239 2032 2039 2003 939 2039 182 182 182 939 848 8282 83 28 38', '2
4
2
8
97
99
12
19
9
12
480
7328
24885
84591
44042
69427
142309
284586', '18
2 1 4
3 2 4 5
2 8 2
3 3 8 9
2 2 101
3 5 4 105
4 2 9 15 11
5 2 4 230 4 3
6 1 4 6 5 4 3
7 1 4 3 4 5 7 7
7 20 23 193 92 91 23 23
11 239 2032 20 203 93 203 182 1812 182 939 35
16 218 303 1432 892 9239 928 1427 38 74 2 93 293 93 920 12092 9
20 8318 838 290 309 9913 283 82 2 38 283 76 37 98 26339 9239 20930 929 929 9228 1239
30 2873 2338 813 722 2283 2273 28382 28 23 838 27 38 48 48 84 848 8382 83 28 38 9 2 39 239 2 31 923 833 23 938
50 38 38 48 2092 932 3 34 23 43 38 38 920 1 9239 92 2 3 2 2039 2053 939 26 892 848 84 848 8282 93 920 48 2092 932 892 848 84 848 8282 93 920 1 9239 1 92 9132 892 848 841 848 2092 932
101 26 92 9132 892 848 841 3 34 23 43 38 38 48 2092 932 892 848 84 848 8282 93 920 1 4 48 2092 932 892 848 84 848 8282 93 920 1 9239 1 29 2 39 239 2 3 93 83 283 938 2873 238 83 72 283 273 28382 28 23 838 27 38 48 848 84 239 2032 2039 2003 939 2039 182 182 182 939 848 8282 83 28 38 9239 92 2 3 2 2039 2053 939 26 92 82 2 38 283 76 37 932 892 848 84 848 8282 93 920
202 26 92 9132 892 848 841 3 34 23 43 38 38 48 2092 932 892 848 84 848 8282 93 920 1 9239 92 2 3 2 2039 2053 939 26 92 9132 892 848 841 848 2092 932 892 848 84 848 8282 93 920 48 2092 932 892 848 84 848 8282 93 920 1 9239 1 29  938 2873 238 83 72 283 273 28382 28 23 838 27 38 58 26 92 9132 892 848 841 3 34 23 43 38 38 48 2092 932 892 848 86 848 8282 93 920 1 9239 92 2 3 2 2039 2153 939 26 92 9132 892 848 841 848 2092 932 892 848 84 848 8282 93 9210 48 2092 932 892 848 84 848 8282 93 920 1 9239 3 29 2 39 239 2 3 93 183 283 938 2873 238 83 72 283 273 28382 28 23 838 57 38 48 848 84 2319 20312 2039 2003 939 2039 182 182 182 939 848 8282 83 28 36 848 84 2329 2032 2039 2003 939 2039 182 2 29 239 2 3 93 83 283 182 182 939 848 8382 83 28 38 4 6', '3
3
6
6
99
101
15
229
7
11
310
4713
26413
86404
52302
65339
130224
315806');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (12, 10050, 'Hartals', '10050 - Hartals', 'https://onlinejudge.org/external/100/p10050.pdf', 1, '//uva10050
#include<iostream>
using namespace std;
int main(){

    int test_case ;
    int N ; // Days
    int P ; // number of political parties
    int P1[100] ;
    int x ;
    int sum = 0 ;
    int hartal_parameter[3651];

    // input
    cin >> test_case ;

    for(int i=0 ; i<test_case ; i++){

        int counter = 0;

        cin >> N >> P;
        for(int j=0 ; j<P ; j++) cin>> P1[j] ;

        //init
        for(int j=0 ; j<=N ; j++) hartal_parameter[j] = 0 ;


         // calculate hartal_parameter ;
        for(int j=0 ; j<P ;j++){

            x = P1[j] ;
            sum = 0;
            while(sum <= N) {

                hartal_parameter[sum] = 1;
                sum += x ;
            }

        }

        //delete Fri Sat

        for(int j=1 ; j<=N ; j++){

            if(j%7 == 6 || j%7 == 0) hartal_parameter[j] = 0;

        }

        for(int j=1 ; j<=N ; j++){

            if (hartal_parameter[j] == 1) counter++;

        }

        cout << counter << endl ;
        //fout<<counter<<endl;
    }

    return 0 ;

}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '15
14
3
3
4
8
100
4
12
15
25
40
14
1
3
14
1
4
14
1
8
100
1
2
100
2
10
15
100
5
2
5
7
9
11
100
5
3
3
3
3
3
1000
2
10
15
2000
5
12
23
25
6
3
3000
10
2
3
4
5
6
12
8
9
10
11
3650
20
2
4
6
8
10
12
13
16
18
20
19
23
25
27
29
31
33
36
37
39
2500
6
2
5
7
3
8
2900
5
2
3
4
9
98', '5
15
3
3
1
36
10
49
24
95
555
1624
1703
1310
2', '15
100
3
3
4
8
100
4
12
15
23
40
100
1
3
100
1
4
100
1
8
150
1
3
150
2
10
16
150
5
2
5
8
9
13
150
5
4
4
4
4
4
1050
2
8
12
2050
5
11
24
10
6
3
3050
10
2
15
4
3
6
12
8
9
10
14
3650
20
2
4
6
15
10
34
13
16
18
20
19
33
25
27
29
31
56
36
37
49
2550
6
2
6
7
12
8
2900
5
2
3
4
5
73', '37
15
24
19
10
36
17
71
27
127
666
1453
1716
911
2');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (13, 10055, 'Hashmat the brave warrior', '10055 - Hashmat the brave warrior', 'https://onlinejudge.org/external/100/p10055.pdf', 1, '//uva10055
#include <bits/stdc++.h>

using namespace std;

int main() {
    long long int n, m;
    while (cin >> n >> m) {
        cout << abs(m - n)<<endl;
    }
    return 0;
}', '10 12
10 14
100 200', '2
4
100', '未考過此題', '未考過此題', '未考過此題', '未考過此題');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (14, 10056, 'What is the Probability!!', '10056 - What is the Probability!!', 'https://onlinejudge.org/external/100/p10056.pdf', 1, '//uva10056
#include <iostream>
#include <math.h>
#include <iomanip>
using namespace std;

int main() {
	int num;
	cin >> num;
	for (int i = 0; i < num; i++) {
		int player_num, player_n;
		double prob;
		cin >> player_num >> prob >> player_n;
		double q = 1 - prob;
		double second = pow(q, player_num);
		if (second == 1) {
			cout << \"0.0000\" << endl;
			continue;
		}
		double ans = prob * pow(q, player_n - 1) / (1.0 - pow(q, player_num));
		cout << fixed << setprecision(4) << ans << endl;
	}

	//system(\"PAUSE\");
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '15
2 0.166666 1
2 0.166666 2
100 0.000001 99
23 0.1111 13
1 1.0 1
1000 0.0001 500
13 0.111111 5
12 0.123456 10
12 0.123456 2
100 0.000001 1
999 0.00023 591
915 0.166666 1
1000 0.265453 873
630 1.0 321
112 0.010101 93', '0.5455
0.4545
0.0100
0.0290
1.0000
0.0010
0.0885
0.0475
0.1362
0.0100
0.0010
0.1667
0.0000
0.0000
0.0058', '17
2 0.166666 1
2 0.166566 2
100 0.010001 1
999 0.00023 591
915 0.166466 1
1 1.0 2
2 1.0 1
7 0.333333 4
123 0.273627 29
12 0.000011 10
12 0.005001 2
100 0.400001 99
23 0.1111 13
371 0.273627 187
163 0.168666 93
178 0.124456 122
452 0.010236 271', '0.5455
0.4546
0.0158
0.0010
0.1665
0.0000
1.0000
0.1049
0.0000
0.0833
0.0852
0.0000
0.0290
0.0000
0.0000
0.0000
0.0006');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (15, 10057, 'A mid-summer night’s dream', '10057 - A mid-summer night’s dream', 'https://onlinejudge.org/external/100/p10057.pdf', 1, '//uva10057
#include <iostream>
#include <algorithm>
#include <map>
using namespace std;
 
int main() {
    int n;
    while (cin >> n){
        int a[n];
        for (int i = 0; i < n; i++){
            cin >> a[i];
        }
        sort(a, a+n);
        int mid1 = a[(n-1)/2];
        int mid2 = a[n/2];
        int ans = 0;
        for (int i = 0; i < n; i++){
            if (a[i] == mid1 || a[i] == mid2) ans++;
        }
        cout << mid1 << \" \" << ans << \" \" << mid2 - mid1 + 1 << \"\\n\";
    }
    return 0;
}', '2
10
10
4
1
2
2
4', '10 2 1
2 2 1', '未考過此題', '未考過此題', '未考過此題', '未考過此題');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (16, 10062, 'Tell me the frequencies!', '10062 - Tell me the frequencies!', 'https://onlinejudge.org/external/100/p10062.pdf', 1, '//uva10062
#include <iostream>
#include <algorithm>
#include <string>
using namespace std;

int main(){
    string str;
    int count = 0;
    while (getline(cin, str)){
        if (count > 0){
            cout << endl;
        }
        int freq[95]; // ascii 126~32
        for (int i = 0; i < 95; i++){
            freq[i] = 10000;
        }

        // calculate the frequency of each char
        int tmp = 0;
        for (int i = 0; i < str.length(); i++){
            tmp = 126 - (int)str[i];
            if (freq[tmp] == 10000){
                freq[tmp] = 0;
            }
            freq[tmp]++;
        }

        // find the least frequency char and print it
        int index;
        index = distance(freq, min_element(freq, freq + 95));
        tmp = freq[index];
        while (tmp != 10000){
            for (int i = index; i < 95; i++){
                if (freq[i] == tmp){
                    cout << 126 - i << \" \" << freq[i] << endl;
                    freq[i] = 10000;
                }
            }
            index = distance(freq, min_element(freq, freq + 95));
            tmp = freq[index];
        }
        count++;
    }
    return 0;
}', 'AAABBC
122333', '67 1
66 2
65 3

49 1
50 2
51 3', '測資在此執行有問題', '測資在此執行有問題', '測資在此執行有問題', '測資在此執行有問題');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (17, 10071, 'Back to High School Physics', '10071 - Back to High School Physics', 'https://onlinejudge.org/external/100/p10071.pdf', 1, '//uva10071
#include <stdio.h>

int main(void){
    int v, t;
    while (scanf(\"%d %d\", &v, &t) != EOF)
        printf(\"%d\\n\", v * t * 2);
    return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '0 0
5 12
-95 68
6 78
-66 141
3 6
-31 138
-1 42
100 200
26 184
33 108
20 18
-8 4
-1 97
-100 1
45 179
68 57
21 191
36 15
-80 12
17 130
-69 167', '0
120
-12920
936
-18612
36
-8556
-84
40000
9568
7128
720
-64
-194
-200
16110
7752
8022
1080
-1920
4420
-23046', '62 33
-55 79
-29 87
180 127
28 110
34 0
28 91
-66 184
-96 16
25 106
73 14
-92 129
-24 33
0 144
-26 83
-100 200
-14 59
-78 140
-17 36
-50 100
1 87
47 71', '4092
-8690
-5046
45720
6160
0
5096
-24288
-3072
5300
2044
-23736
-1584
0
-4316
-40000
-1652
-21840
-1224
-10000
174
6674');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (18, 10093, 'An Easy Problem!', '10093 - An Easy Problem!', 'https://onlinejudge.org/external/100/p10093.pdf', 1, '//uva10093
#include <iostream>
#include <string>
#include <unordered_map>
#include <algorithm>
using namespace std;

int main() {
	int n, temp, max_num, total;
	string s, output;
	unordered_map<char, int> m;

	for (int i = 0; i < 10; ++i)
		m[\'0\' + i] = i;
	for (int i = 0; i < 26; ++i)
		m[\'A\' + i] = 10 + i;
	for (int i = 0; i < 26; ++i)
		m[\'a\' + i] = 36 + i;
	m[\'-\'] = 0;

	while (cin >> s) {
		n = s.length();
		total = 0;
		max_num = 1;
		for (int i = 0; i < n; ++i) {
			temp = m[ s[n - i - 1] ];
			total += temp;
			max_num = max(max_num, temp);
		}
		
		output = \"such number is impossible!\";
		for (int i = max_num + 1; i <= 62; ++i) {
			if (total % (i - 1) == 0) {
				output = to_string(i);
				break;
			}
		}

		cout << output << endl;
	}


	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '3
5
A
2
4
6
7
8
9
10
11
B
Z
236
752
8364
283429
Arping
765
kjlsdf
2432
AAA
ABCDee
23khasf
123456789
987654321
Cbyang
CBYANG
101010
1234GHIJK
15678BCDEF7
kwkkwe
283jsjjnsjkzs', '4
6
11
3
5
7
8
9
10
2
2
12
36
12
8
22
15
such number is impossible!
10
such number is impossible!
12
11
43
such number is impossible!
10
10
such number is impossible!
54
2
21
34
such number is impossible!
such number is impossible!', '6
827
9723
732AC
sjkksd
2i238
VDAC
eJ2x
BDv
cU
CZA2
ms
3jkVT
BAG
BBCD
NgM
TCL
p2
2734
Chouhl
Ih
ABCD
VKsjR
VCDX
283j439
sbFS
28338
2886
291
vzxyw', '7
18
22
18
such number is impossible!
60
34
61
such number is impossible!
such number is impossible!
60
such number is impossible!
such number is impossible!
38
48
such number is impossible!
32
54
9
such number is impossible!
62
24
60
such number is impossible!
such number is impossible!
such number is impossible!
9
9
13
such number is impossible!');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (19, 10101, 'Bangla Numbers', '10101 - Bangla Numbers', 'https://onlinejudge.org/external/101/p10101.pdf', 1, '//uva10101
#include <iostream>
#include <string>
using namespace std;
string table[] = {\"\", \"shata\", \"hajar\", \"lakh\", \"kuti\"};

int main() {
	int i = 1;
	long long int n;
	while((cin >> n)){
		string s = \"\";
		int t = 1, temp = 0;

		if(n == 0)
			s = \"0\";
		else{
			temp = n % 100;
			if(temp != 0)
				s.insert(0, to_string(temp));
			n = n /100;
		}
		while(n>0){
			if(t % 4 == 1){
				temp = n % 10;
				n /= 10;
			}
			else{
				temp = n % 100;
				n /= 100;
			}
			if(temp != 0){
				if(s.compare(\"\") != 0)
					s.insert(0, to_string(temp) + \" \" + table[t] + \" \");
				else
					s.insert(0, to_string(temp) + \" \" + table[t]);
			}
			else if(temp == 0 && t % 4 == 0){
				if(s.compare(\"\") != 0)
					s.insert(0, table[t] + \" \");
				else
					s.insert(0, table[t]);
			}
			t = (t % 4) + 1;
		}
		if(i < 10)
			cout << \"   \";
		else if(i < 100)
			cout << \"  \";
		else if(i < 1000)
			cout << \" \";
		cout << i++ << \". \" << s << endl;
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '23764 
45897458973958
0
15
45
146
890
300
3409
12345
45540
50000
76867
545600
4000000
5300000000
2343209230
18293921231
20020302234323
20000000000000
761000000000000
234000000003400
123456789012345
999999999999999', '   1. 23 hajar 7 shata 64
   2. 45 lakh 89 hajar 7 shata 45 kuti 89 lakh 73 hajar 9 shata 58
   3. 0
   4. 15
   5. 45
   6. 1 shata 46
   7. 8 shata 90
   8. 3 shata
   9. 3 hajar 4 shata 9
  10. 12 hajar 3 shata 45
  11. 45 hajar 5 shata 40
  12. 50 hajar
  13. 76 hajar 8 shata 67
  14. 5 lakh 45 hajar 6 shata
  15. 40 lakh
  16. 5 shata 30 kuti
  17. 2 shata 34 kuti 32 lakh 9 hajar 2 shata 30
  18. 1 hajar 8 shata 29 kuti 39 lakh 21 hajar 2 shata 31
  19. 20 lakh 2 hajar 30 kuti 22 lakh 34 hajar 3 shata 23
  20. 20 lakh kuti
  21. 7 kuti 61 lakh kuti
  22. 2 kuti 34 lakh kuti 3 hajar 4 shata
  23. 1 kuti 23 lakh 45 hajar 6 shata 78 kuti 90 lakh 12 hajar 3 shata 45
  24. 9 kuti 99 lakh 99 hajar 9 shata 99 kuti 99 lakh 99 hajar 9 shata 99', '0
12
57
234
2388
32493
45000
123003
2132000
12398123
700000000
234349090
23400043330
12399300002
123999345034
210000002300
2038302390000
23002222200000
203928299990009
200000000000000
820000000003200
234560000000023
999999999999999', '   1. 0
   2. 12
   3. 57
   4. 2 shata 34
   5. 2 hajar 3 shata 88
   6. 32 hajar 4 shata 93
   7. 45 hajar
   8. 1 lakh 23 hajar 3
   9. 21 lakh 32 hajar
  10. 1 kuti 23 lakh 98 hajar 1 shata 23
  11. 70 kuti
  12. 23 kuti 43 lakh 49 hajar 90
  13. 2 hajar 3 shata 40 kuti 43 hajar 3 shata 30
  14. 1 hajar 2 shata 39 kuti 93 lakh 2
  15. 12 hajar 3 shata 99 kuti 93 lakh 45 hajar 34
  16. 21 hajar kuti 2 hajar 3 shata
  17. 2 lakh 3 hajar 8 shata 30 kuti 23 lakh 90 hajar
  18. 23 lakh 2 shata 22 kuti 22 lakh
  19. 2 kuti 3 lakh 92 hajar 8 shata 29 kuti 99 lakh 90 hajar 9
  20. 2 kuti kuti
  21. 8 kuti 20 lakh kuti 3 hajar 2 shata
  22. 2 kuti 34 lakh 56 hajar kuti 23
  23. 9 kuti 99 lakh 99 hajar 9 shata 99 kuti 99 lakh 99 hajar 9 shata 99');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (20, 10170, 'The Hotel with Infinite Rooms', '10170 - The Hotel with Infinite Rooms', 'https://onlinejudge.org/external/101/p10170.pdf', 1, '//uva10170
#include <iostream>
using namespace std;
int main()
{
   long long int S,D;
   long long int area;
   while(cin >> S >> D) {
      for(int i = 0; ; i++) {
         area = (S + (S + i)) * (i + 1) / 2;
         if(area >= D) {
            cout << S + i << endl;
            break;
         }
      }
   }
   return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '1 6
3 10
3 14
1 1000
10 1000
333 32777
555 46345
1234 123456789012345
5566 183183183183183
9898 989898989898989
10000 999999999999999
5 4
5 5
5 6
5 7', '3
5
6
45
46
420
633
15713484
19140700
44494922
44721361
5
5
6
6', '1 7
4 15
4 18
2 2000
20 2000
555 32345
666 46369
4321 543210123456789
7879 789789789789789
10000 999999999999999
8989 898989898989898
7 6
7 7
7 8
7 9', '4
6
7
63
66
610
732
32960890
39743926
44721361
42402593
7
7
8
8');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (21, 10189, 'Minesweeper', '10189 - Minesweeper', 'https://onlinejudge.org/external/101/p10189.pdf', 1, '//uva10189
#include <iostream>
using namespace std;
int n,m;
char line[100][101];
int ans[100][100];
int field=0;
void input()
{
   for(int i=0;i<n;i++){
      cin>>line[i];
      for(int j=0;j<m;j++){
         ans[i][j]=0;
      }
   }
}
void MineAddNeighborOne(int i,int j)
{
   for(int ii=i-1;ii<=i+1;ii++){
      for(int jj=j-1;jj<=j+1;jj++){
         if(ii<0||ii>=n||jj<0||jj>=m)
            continue;
         ans[ii][jj]++;
      }
   }
}
void output()
{
   for(int i=0;i<n;i++){
      for(int j=0;j<m;j++){
         if(line[i][j]==\'*\'){
            MineAddNeighborOne(i,j);
         }
      }
   }
   if(field>1)cout<<endl;
   cout<<\"Field #\"<<field<<\":\"<<endl;
   for(int i=0;i<n;i++){
      for(int j=0;j<m;j++){
         if(line[i][j]==\'*\'){
            cout<<\'*\';
         }else{
            cout<<ans[i][j];
         }
      }
      cout<<endl;
   }
}
int main()
{
   while(cin>>n>>m){
      if(n==0 && m==0)break;
      input();
      field++;
      output();
   }
   return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '測資過長', '測資過長', '測資過長', '測資過長');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (22, 10190, 'Divide, But Not Quite Conquer!', '10190 - Divide, But Not Quite Conquer!', 'https://onlinejudge.org/external/101/p10190.pdf', 1, '//uva10190
#include <cmath>
#include <iostream>
using namespace std;

int main() {
    long long n, m, i;

    while (cin >> n >> m) {
        long long cn1 = m;

        for (i = 1; cn1 < n && m > 1; i++) {
            cn1 = pow(m, i);
        }

        if (cn1 > n || m <= 1) {
            cout << \"Boring!\" << endl;
        } else {
            while (cn1 > 0) {
                cout << cn1;
                if (cn1 != 1) {
                    cout << \" \";
                } else {
                    cout << endl;
                }
                cn1 /= m;
            }
        }
    }
    return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '125 5
30 3
80 2
81 3
16 4
10 1
109 0
23 23
12 144
25 3
49 7
0 0
1 1
2 2
1000000 10
67108864 4
134217728 8
32768 8
1073741824 8
170859375 15
293 115
100 50
170859375 15
256 16
1048576 16
290 283
8000 20
285 5
148035889 23
15625 25
676 26
481890304 28
841 29
32768 32
1073741824 4
39135393 33
1100 34
4477456 46
6 3
2209 47
1303210000 190', '125 25 5 1
Boring!
Boring!
81 27 9 3 1
16 4 1
Boring!
Boring!
23 1
Boring!
Boring!
49 7 1
Boring!
Boring!
2 1
1000000 100000 10000 1000 100 10 1
67108864 16777216 4194304 1048576 262144 65536 16384 4096 1024 256 64 16 4 1
134217728 16777216 2097152 262144 32768 4096 512 64 8 1
32768 4096 512 64 8 1
1073741824 134217728 16777216 2097152 262144 32768 4096 512 64 8 1
170859375 11390625 759375 50625 3375 225 15 1
Boring!
Boring!
170859375 11390625 759375 50625 3375 225 15 1
256 16 1
1048576 65536 4096 256 16 1
Boring!
8000 400 20 1
Boring!
148035889 6436343 279841 12167 529 23 1
15625 625 25 1
676 26 1
481890304 17210368 614656 21952 784 28 1
841 29 1
32768 1024 32 1
1073741824 268435456 67108864 16777216 4194304 1048576 262144 65536 16384 4096 1024 256 64 16 4 1
39135393 1185921 35937 1089 33 1
Boring!
4477456 97336 2116 46 1
Boring!
2209 47 1
1303210000 6859000 36100 190 1', '0 0
1 1
2 2
4194304 2
8192 2
3 9
10 5
310 117
9 3
40353607 7
5764801 7
310 219
1220703125 5
9978 9861
1000000000 10
121 11
1162261467 3
248832 12
225 15
1419857 17
361 19
893871739 19
6859 19
400 20
6436343 23
576 24
7962624 24
625 25
173 90
20511149 29
810000 30
961 31
1024 32
1838265625 35
1296 36
69343957 37
130691232 42
3136 56
3721 61
226981 61
992436543 63
4624 68
328509 69
1564031349 69', 'Boring!
Boring!
2 1
4194304 2097152 1048576 524288 262144 131072 65536 32768 16384 8192 4096 2048 1024 512 256 128 64 32 16 8 4 2 1
8192 4096 2048 1024 512 256 128 64 32 16 8 4 2 1
Boring!
Boring!
Boring!
9 3 1
40353607 5764801 823543 117649 16807 2401 343 49 7 1
5764801 823543 117649 16807 2401 343 49 7 1
Boring!
1220703125 244140625 48828125 9765625 1953125 390625 78125 15625 3125 625 125 25 5 1
Boring!
1000000000 100000000 10000000 1000000 100000 10000 1000 100 10 1
121 11 1
1162261467 387420489 129140163 43046721 14348907 4782969 1594323 531441 177147 59049 19683 6561 2187 729 243 81 27 9 3 1
248832 20736 1728 144 12 1
225 15 1
1419857 83521 4913 289 17 1
361 19 1
893871739 47045881 2476099 130321 6859 361 19 1
6859 361 19 1
400 20 1
6436343 279841 12167 529 23 1
576 24 1
7962624 331776 13824 576 24 1
625 25 1
Boring!
20511149 707281 24389 841 29 1
810000 27000 900 30 1
961 31 1
1024 32 1
1838265625 52521875 1500625 42875 1225 35 1
1296 36 1
69343957 1874161 50653 1369 37 1
130691232 3111696 74088 1764 42 1
3136 56 1
3721 61 1
226981 3721 61 1
992436543 15752961 250047 3969 63 1
4624 68 1
328509 4761 69 1
1564031349 22667121 328509 4761 69 1');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (23, 10193, 'All You Need Is Love!', '10193 - All You Need Is Love!', 'https://onlinejudge.org/external/101/p10193.pdf', 2, '//uva10193
#include <iostream>
#include <string>
using namespace std;

int int_str(const string &s) {
	int x = 0, len = s.length();
	for (int i = 0; i < len; i++) x *= 2, x += s[i] - \'0\';
	return x;
}

int gcd(int a,int b) {
	while ((a %= b) && (b %= a));
	return a + b;
}

int main() {
	int n;
	cin >> n;
	for (int i = 1; i <= n; i++) {
		string a,b;
		cin >> a >> b;
		
		cout << \"Pair #\" << i << \": \";
		if (gcd(int_str(a), int_str(b)) != 1) {
			cout << \"All you need is love!\" << endl;
		} else {
			cout << \"Love is not all you need!\" << endl;
		}
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '7
11011
11001
111000
110001
10010
1010011
110000001
110000110
111
111
1101000010001000011110111000
1110010000111100011101110001
101111101000011001100111111011
110111111101001110111011110101', 'Pair #1: Love is not all you need!
Pair #2: All you need is love!
Pair #3: Love is not all you need!
Pair #4: All you need is love!
Pair #5: All you need is love!
Pair #6: Love is not all you need!
Pair #7: All you need is love!', '7
101
101
110000111011110111110001001000
101111100000000111011111010111
10110100101010110111010010000
10000011101101111011101101111
101100
1001101
100001
100011
110000001
111100011
1011011
1000100', 'Pair #1: All you need is love!
Pair #2: All you need is love!
Pair #3: Love is not all you need!
Pair #4: All you need is love!
Pair #5: Love is not all you need!
Pair #6: All you need is love!
Pair #7: Love is not all you need!');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (24, 10221, 'Satellites', '10221 - Satellites', 'https://onlinejudge.org/external/102/p10221.pdf', 1, '//uva10221
#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;
#define PI acos(0.0)*2.0
 
int main() {
    double r, s, a;
    string unit;
    double chord, arc;
    r = 6440.0;
    while (cin >> s >> a >> unit){
        if (unit == \"min\") a /= 60.0;
        if (a > 180.0) a = 360.0 - a;
        chord = (r+s) * cos((90.0 - a/2.0)/ 180.0 * PI) * 2.0;
        arc = 2.0 * PI * (r+s) * a / 360.0;
        cout << fixed << setprecision(6) << arc << \" \" << chord << \"\\n\";
    }
    return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '500 30 deg
700 60 min 
200 45 deg
500 1800 min
700 1 deg
200 2700 min
100 0 deg
100 0 min
1000 1 deg
1000 60 min
2393 28 min
300 25 deg
600 180 deg
6440 140 deg
3023 157 deg
8023 55 min', '3633.775503 3592.408346
124.616509 124.614927
5215.043805 5082.035982
3633.775503 3592.408346
124.616509 124.614927
5215.043805 5082.035982
0.000000 0.000000
0.000000 0.000000
129.852496 129.850848
129.852496 129.850848
71.943635 71.943436
2940.879790 2917.605996
22116.812281 14080.000000
31471.777072 24206.481911
25930.199617 18546.054960
231.391389 231.388921', '272 50 deg
7300 160 min 
2200 15 deg
3300 180 deg
63400 160 deg
60 3689 min
7200 2 deg
54500 620 min
12393 2900 min
5230 131 deg
32323 137 deg
9223 50 min
2300 5233 min
123 123 deg
63740 23 min
12300 12 deg', '5857.324970 5673.227546
639.488638 639.430921
2261.946711 2255.492602
30599.112446 19480.000000
195030.071935 137557.946941
6975.062911 6645.185106
476.125820 476.101648
10990.571010 10975.681924
15887.063138 15420.170919
26682.070006 21238.496062
92686.250979 72131.552375
227.809101 227.807093
13304.185285 12056.390605
14089.152933 11535.353421
469.534293 469.533417
3924.896422 3917.726803');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (25, 10222, 'Decode the Mad man', '10222 - Decode the Mad man', 'https://onlinejudge.org/external/102/p10222.pdf', 1, '//uva10222
#include <iostream>
#include <string>
using namespace std;

int main() {
    string dic = \"`1234567890-=qwertyuiop[]\\\\asdfghjkl;\'zxcvbnm,./\";

    int N;
    cin >> N;
    cin.ignore();
    while (N--) {
        string words;
        getline(cin, words);
        for (int i = 0; i < words.size(); ++i) {
            if (\'A\' <= words[i] && words[i] <= \'Z\')
                words[i] += 32; // to lower case
            int pos = dic.find(words[i]);
            if (pos != -1)
                words[i] = dic[pos - 2];
        }
        cout << words << endl;
    }

    return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '19
K[R DYT I[o
J[[g .[Y,P,j
KT\'\'[ R[Y\'G
ertdFGcVb
ERTyUioP[]
dfGHjKl;\'cVB
UkPf pf uKt hpYFu UTFu Bdft
E]t[YpuOId\'F;gLhKJCV.B,nM
d,G uKTYT DYt .[yT UKD, uT, bdFtF
p, UKt EOTfup[, I[O kDNt u[ P.]Y[NT I[OY
b[gT PF b[YytBU D,G P RP\'\' uT\'\' I[o rKTUkTy I[oY d,fRty PF DBbT]UTg [Y ,[U
H[Y ukt FTB[,G BDFt G[ i[O uKp,; ukT Ft,ut,FTF .d;t fT,FT Ph i[O uKP,; f[ i[o dyt Ry[,J
rK[ u[\'G i[O ukDU UKT ft,ut,ftF .d;t Ft,fT .Dimt lOfU d \'[U [H .tD,P,j\'TFf r[yGf D,G ]Ou U[jtukTy b[p,bpGt,U\'I
.d;t FoYt d]]\'T UkDU Md,d,d Bd, gtbPgt T\'t]kD,U u[ HpJKU RpUK jPYdHHT Kdnp,j p.][fFPM\'t l[;T \'dUT .[NP,j ,[yuk []][F
][]P,j ;gD EoTFup[, ypjku y[o,g F[O,g ft\'\' FTU Uyouk UyOfu ud\'\' oh[ o,p[, O,PH[Y. O,phPTG nput N[uT np\'\'dJt rdi rDv RdNt VYDI vrKDu
iTfu itf i[oyF i[O,Jty ],to.[,[o\'Uyd.PBy[fb[]PBfp\'pB[N[\'BD,[B[,p[FPf FI,bKy[,[OF Gpd]KYdJ.DUPB H\'ouutY FUTy,OUDUT m[ym[yIj.Of f;t\'TU[,
mydp, ktdYu \'o,jF \'pNtY f[U.dkb F.D\'\' P,utFuP,T \'DYjt P,fUTRtuP,T dMG[.T,. dM.o\'dy,Bt md,gdJT Mp\'dUTtYd\'  Bd,bTY BDfu b[\'[, BYUbkTf gpDj
,[fpf t.tyJT,TBi TvUyT.PUI HTNY H\'o hYdbuoYt Kty,pd pb,FPfP[, p,]DUpt,U \'tFp[, []TdYUp[, [yJd,f [Ou]Dupt,U ]Dp,. ]kIFPBD\' ]Y[fUKTFfpF DFdB
nDBBP,T N[.Pu RkTt\'BKpDY  bDYgP[nDfBO\'dy b[y[,Dyi JdfUY[P,Utfup,d\' p,UTJo.T,u .oFbd\'odY ,tyn[oF fIFut. ,tYo[\'[jPbd\' yTF]PYdu[YTi F;T\'Tud\'  FT,F[YI oyP,DYi', 'how are you
good morning
hello world
qweasdzxc
qwertyuiop
asdfghjklzxc
this is the first test case
qpeorituyalskdjfhgzxmcnvb
and there are more than ten cases
in the question you have to improve your
code is correct and i will tell you whether your answer is accepted or not
for the second case do you think the sentenses make sense if you think so you are wrong
who told you that the sentenses make sense maybe just a lot of meaningless words and put together coincidently
make sure apple that banana can decide elephant to fight with giraffe having impossible joke late moving north oppos
poping kda question right round sound sell set truth trust tall ufo union uniform unified vite vote village way wax wave xray xwhat
yest yes yours younger pneumonoultramicroscopicsilicovolcanoconiosis synchronous diaphragmatic flutter sternutate borborygmus skeleton
brain heart lungs liver sotmahc small intestine large instewetine abdomenm abmularnce bandage bilateeral  cancer cast colon crtches diag
nosis emergenecy extremity fevr flu fracture hernia icnsision inpatient lesion opeartion organs outpatient painm physical prosthessis asac
vaccine vomit wheelchiar  cardiovascular coronary gastrointestinal integument muscaluar nervous system neruological respiratorey skeletal  sensory urinary', '18
k[r GDyt I[O
j[[g ,PJku tnTyi[,t
FDi kp U[ UKpF b \'D,JodjT
KGdd;u MF.oT\'\'] KJ[K,U U.TdU[kJp
DU[UTUr[ OfTF\'.kD \'g;U fGu,P[ jfNDTDp[[ DmBB
,PgKYU \'u]p\'  \'J]tDVfpuPYj .ttK,OpTB fjUuPFRyKt D.TTu
dFyBPfyy u.OK ddh,;Fypf[;u p,ifE,d, [JhuIB PKdUtUBR[ 
UKutykkfT [.FtD.rTPy  GFu\'ydju  TKKrnHByptpG[f,Yf[ KtGtd f;i
db t[F\'Y,UP ojTuk g\'F,d \',br jHDPk\' .YTJYGbuD po,H.putTPFD,d nD,ph.U
uK,u\'  IptT Gf,hP, D]J,[,Yj, nP,Tjp TFKOu fky[fD[, fuKBPu[bPg o\'\'uUu
T\'UTFt peKFuHPO[Y PpDugR.Tb,[M,T bNFMY k[YtUOu.F b\'[\'p,N.okkId,,puR\'tHTtOt,tut
m[bk[[ogFK.Ptb[Gd GtMGtgHtj yPDTh UfbKPjKF d.yypK],[G mGDPy[\'TUt.[m tPyOD\'DgmJiU]Gd
yYf[.[P, dMuk [OUGgtUf[ \'y[FrFKDT tOf\'DuFD[NUtBit,[TTPmJ tR\',ooFu[gtK KDUOOJ]drKDUJy,
Bu[,D[,,Kr\'fG u.jyTyUD,T Uf]TyRkj T\'t pYkk,B bT.TBDPDKK,UbD tk\'D]fk,oh\'t,u,p[ \'fTT[TPbtYkk
KTdUjFT[,]KtgdIpffrDpDgrGt,pOU,\'DtY;TJDKfFhtyPbytN[oY]\'dMf]I]\'ouKbTY\'\'FT[D[d]NbDYT,FD][[tpKYTfp\'TGO
kttfF\'FK[p],PT P[]I] ndGOobtfG .[FT\'Tfgt .tT\' b[[. ,[[Bty FJ;pyjtY[ fGktuJdpB\'[muu y[\'[gy[tf gFBp\'PK
MFyT,tGD[ [,Dg id[,tuI YPyIFtfNi \'.ty\'id f,,[Rky\'ND \'uKjg\'bIUU;hT[g, pT ,tfFtUyt,Yt KDbidu[..tRU,]Ytyb\'[,gy[M
[t[TUT.yK]MdYf\'If,koHIh.Enj JuT\'TJRdfFk\'BDTdU\'.vyD IbkUk,tkM]uIkguDPT,y,yU UDtTH.OfDtH,uyhYRdp pPgU.O[ UUupmtbTK[kR\'uGodDk[fkj,', 'how dare you
good night everyone
say hi to this c language
hdaakt bsmuellp hgohnt tmeatohgi
atotetwo useslmha ldkt sdtnio gsvaeaioo abcc
nidhrt ltpil  lgpeaxsitirg meehnuiec sgttiswrhe ameet
asrcisrr tmuh aafnksrisokt inysqnan ogftyc ihatetcwo 
thterhhse omseamweir  dstlragt  ehhwvfcrieidosnrso hedea sky
ac eoslrnti ugeth dlsna lncw gfaihl mregrdcta iunfmiteeisana vanifmt
thntl  yiee dsnfin apgnonrgn vinegi eshut shrosaon sthcitocid ullttt
eltese iqhstfiuor iiatdwmecnobne cvsbr horetutms clolinvmuhhyannitwlefeeuenete
bochooudshmiecoda debdedfeg riaef tschighs amrrihpnod bdairoletemob eirualadbgytpda
rrsomoin abth outddetso lroswshae euslatsaovtecyenoeeibg ewlnuustodeh hatuugpawhatgrn
ctonaonnhwlsd tmgrertane tsperwhg ele irhhnc cemecaiahhntca ehlapshnuflentnio lseeoeicerhh
heatgseonphedayisswaiadwdeniutnlaerkegahssfericrevourplabspypluthcerllseoaoapvcarensapooeihresiledu
heesslshoipnie iopyp vaduucesd moselesde meel coom noocer sgkirgero sdhetgaiclobtt rolodroes dscilih
bsrenedao onad yaonety rirysesvy lmerlya snnowhrlva lthgdlcyttkfeodn ie nessetrenre hacyatommewtnprerclondrob
oeoetemrhpbarslysnhufyfmqvg gtelegwasshlcaeatlmxra ychthnehbptyhdtaienrnrt taeefmusaefntrfrwai iidtmuo tttibecehohwltduaahoshgn');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (26, 10226, 'Hardwood Species', '10226 - Hardwood Species', 'https://onlinejudge.org/external/102/p10226.pdf', 1, '//uva10226
#include <iostream>
#include <iomanip>
#include <map>
using namespace std;
 
int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    int n;
    string s;
    cin >> n;
    getline(cin, s); //clear buffer
    getline(cin, s); //blank line
    while (n--){
        map <string, int> mp;
        int sum = 0;
        while (getline(cin, s) && s != \"\"){
            mp[s]++;
            sum++;
        }
        for (auto i: mp){
            cout << i.first << \" \" <<
            fixed << setprecision(4) << (double)i.second / sum * 100 << \"\\n\";
        }
        cout << \"\\n\";
    }
    return 0;
}', '2

Red Alder
Ash
Aspen
Basswood
Ash
Beech
Yellow Birch
Ash
Cherry
Cottonwood
Ash
Cypress
Red Elm
Gum
Hackberry
White Oak
Hickory
Pecan
Hard Maple
White Oak
Soft Maple
Red Oak
Red Oak
White Oak
Poplan
Sassafras
Sycamore
Black Walnut
Willow

Red Alder
Ash
Ash
Aspen', 'Ash 13.7931
Aspen 3.4483
Basswood 3.4483
Beech 3.4483
Black Walnut 3.4483
Cherry 3.4483
Cottonwood 3.4483
Cypress 3.4483
Gum 3.4483
Hackberry 3.4483
Hard Maple 3.4483
Hickory 3.4483
Pecan 3.4483
Poplan 3.4483
Red Alder 3.4483
Red Elm 3.4483
Red Oak 6.8966
Sassafras 3.4483
Soft Maple 3.4483
Sycamore 3.4483
White Oak 10.3448
Willow 3.4483
Yellow Birch 3.4483

Ash 50.0000
Aspen 25.0000
Red Alder 25.0000', '未考過此題', '未考過此題', '未考過此題', '未考過此題');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (27, 10235, 'Simply Emirp', '10235 - Simply Emirp', 'https://onlinejudge.org/external/102/p10235.pdf', 1, '//uva10235
#include<iostream>
using namespace std;

int com[1000000];
int main() {
	for(int i = 2; i < 1000; i++) {
		if(com[i])
			continue;
		for(int j = i + i; j < 1000000; j += i)
			com[j] = 1;
	}
	int n, rn;
	while(cin >> n) {
		int sn = n; 
		for(rn = 0; n; n /= 10) rn = rn * 10 + (n % 10);
		if(com[sn]) cout << sn << \" is not prime.\";
		else if(com[rn]) cout << sn << \" is prime.\";
		else if(sn == rn) cout << sn << \" is prime.\";
		else cout << sn << \" is emirp.\";
		cout << endl;
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '10
5
9
8
4
3
2
7
2
10
5
5
7
8
5
9
4
4
10
94
61
28
66
57
99
45
71
38
59
59
83
73
53
17
11
88
79
28
667
466
533
655
644
800
553
345
879
4189
3663
5789
4024
2638
8319
2048
2601
7995
63307
90065
79732
54566
53190
95273
28990
43263
58322
54701
93598
13091
90531
85729
61881
50800
13516
52515
24850
375010
653834
696919
847599
262144
845875
110603
182861
303017
649045
101622
199547
911186
728662
596023
628089
741945
130765
900236', '10 is not prime.
5 is prime.
9 is not prime.
8 is not prime.
4 is not prime.
3 is prime.
2 is prime.
7 is prime.
2 is prime.
10 is not prime.
5 is prime.
5 is prime.
7 is prime.
8 is not prime.
5 is prime.
9 is not prime.
4 is not prime.
4 is not prime.
10 is not prime.
94 is not prime.
61 is prime.
28 is not prime.
66 is not prime.
57 is not prime.
99 is not prime.
45 is not prime.
71 is emirp.
38 is not prime.
59 is prime.
59 is prime.
83 is prime.
73 is emirp.
53 is prime.
17 is emirp.
11 is prime.
88 is not prime.
79 is emirp.
28 is not prime.
667 is not prime.
466 is not prime.
533 is not prime.
655 is not prime.
644 is not prime.
800 is not prime.
553 is not prime.
345 is not prime.
879 is not prime.
4189 is not prime.
3663 is not prime.
5789 is not prime.
4024 is not prime.
2638 is not prime.
8319 is not prime.
2048 is not prime.
2601 is not prime.
7995 is not prime.
63307 is not prime.
90065 is not prime.
79732 is not prime.
54566 is not prime.
53190 is not prime.
95273 is prime.
28990 is not prime.
43263 is not prime.
58322 is not prime.
54701 is not prime.
93598 is not prime.
13091 is not prime.
90531 is not prime.
85729 is not prime.
61881 is not prime.
50800 is not prime.
13516 is not prime.
52515 is not prime.
24850 is not prime.
375010 is not prime.
653834 is not prime.
696919 is not prime.
847599 is not prime.
262144 is not prime.
845875 is not prime.
110603 is emirp.
182861 is not prime.
303017 is not prime.
649045 is not prime.
101622 is not prime.
199547 is not prime.
911186 is not prime.
728662 is not prime.
596023 is not prime.
628089 is not prime.
741945 is not prime.
130765 is not prime.
900236 is not prime.', '6
9
9
6
7
3
2
9
9
4
9
4
3
8
6
7
7
8
2
97
24
12
55
70
73
75
84
10
67
88
56
44
39
75
62
19
25
75
602
193
733
137
300
570
688
105
371
2491
4311
4867
3208
7605
1533
5624
6813
9110
89895
33439
29437
18592
77052
90432
64190
88281
49605
34528
15983
40627
69716
52868
62939
27387
91678
70898
30809
588545
967990
398882
559837
810537
573932
393269
872030
382981
818386
830706
909428
318403
498234
664738
413484
756831
757428
875497', '6 is not prime.
9 is not prime.
9 is not prime.
6 is not prime.
7 is prime.
3 is prime.
2 is prime.
9 is not prime.
9 is not prime.
4 is not prime.
9 is not prime.
4 is not prime.
3 is prime.
8 is not prime.
6 is not prime.
7 is prime.
7 is prime.
8 is not prime.
2 is prime.
97 is emirp.
24 is not prime.
12 is not prime.
55 is not prime.
70 is not prime.
73 is emirp.
75 is not prime.
84 is not prime.
10 is not prime.
67 is prime.
88 is not prime.
56 is not prime.
44 is not prime.
39 is not prime.
75 is not prime.
62 is not prime.
19 is prime.
25 is not prime.
75 is not prime.
602 is not prime.
193 is prime.
733 is emirp.
137 is prime.
300 is not prime.
570 is not prime.
688 is not prime.
105 is not prime.
371 is not prime.
2491 is not prime.
4311 is not prime.
4867 is not prime.
3208 is not prime.
7605 is not prime.
1533 is not prime.
5624 is not prime.
6813 is not prime.
9110 is not prime.
89895 is not prime.
33439 is not prime.
29437 is prime.
18592 is not prime.
77052 is not prime.
90432 is not prime.
64190 is not prime.
88281 is not prime.
49605 is not prime.
34528 is not prime.
15983 is not prime.
40627 is prime.
69716 is not prime.
52868 is not prime.
62939 is prime.
27387 is not prime.
91678 is not prime.
70898 is not prime.
30809 is emirp.
588545 is not prime.
967990 is not prime.
398882 is not prime.
559837 is not prime.
810537 is not prime.
573932 is not prime.
393269 is not prime.
872030 is not prime.
382981 is not prime.
818386 is not prime.
830706 is not prime.
909428 is not prime.
318403 is emirp.
498234 is not prime.
664738 is not prime.
413484 is not prime.
756831 is not prime.
757428 is not prime.
875497 is not prime.');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (28, 10242, 'Fourth Point!!', '10242 - Fourth Point!!', 'https://onlinejudge.org/external/102/p10242.pdf', 1, '//uva10242
#include <iostream>
#include <ios>
#include <iomanip>
using namespace std;

int main() {
	double x1, y1, x2, y2, x3, y3, x4, y4, x, y;
	while (cin >> x1 >> y1 >> x2 >> y2 >> x3 >> y3 >> x4 >> y4) {
		if (x1 == x3 && y1 == y3) {
			x = x2 + x4 - x1;
			y = y2 + y4 - y1;
		}
		else if (x1 == x4 && y1 == y4) {
			x = x2 + x3 - x1;
			y = y2 + y3 - y1;
		}
		else if (x2 == x3 && y2 == y3) {
			x = x1 + x4 - x2;
			y = y1 + y4 - y2;
		}
		else {
			x = x1 + x3 - x2;
			y = y1 + y3 - y2;
		}

		cout << fixed << setprecision(3) << x << \" \" << fixed << setprecision(3) << y << endl;
	}


	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '0.000 0.000 0.000 1.000 0.000 1.000 1.000 1.000
1.000 0.000 3.500 3.500 3.500 3.500 0.000 1.000
1.866 0.000 3.127 3.543 3.127 3.543 1.412 3.145
0.000 0.000 0.000 1.000 0.000 1.000 1.000 1.000
0.000 0.000 0.000 1.000 1.000 1.000 0.000 1.000
0.000 1.000 0.000 0.000 0.000 1.000 1.000 1.000
0.000 1.000 0.000 0.000 1.000 1.000 0.000 1.000
0.000 0.000 10.000 10.000 10.000 -10.000 0.000 0.000
0.000 0.000 10.000 10.000 10.000 -9.876 0.000 0.000
11.111 22.222 33.333 44.444 11.111 22.222 -33.333 -44.444
5.384 6.284 10.333 8.777 5.384 6.284 15.111 -0.877
3.039 -777.666 -50.000 -30.000 -50.000 -30.000 -49.000 8000
3895.102 3029.999 2.212 3.343 2.212 3.343 4939.888 2016.777
1234.567 7654.321 2345.678 8765.432 -1.000 -2.090 1234.567 7654.321
-4718.901 3049.141 -4869.609 3556.058 -4718.901 3049.141 9376.260 -8396.750
-1857.015 -1618.166 -1487.384 648.181 -2660.848 -6343.281 -1857.015 -1618.166', '1.000 0.000
-2.500 -2.500
0.151 -0.398
1.000 0.000
1.000 0.000
1.000 0.000
1.000 0.000
20.000 0.000
20.000 0.124
-11.111 -22.222
20.060 1.616
4.039 7252.334
8832.778 5043.433
1110.111 1109.021
9225.552 -7889.833
-2291.217 -4076.934', '0.000 0.000 0.000 1.000 0.000 1.000 1.000 1.000
1.000 0.000 3.500 3.500 3.500 3.500 0.000 1.000
1.866 0.000 3.127 3.543 3.127 3.543 1.412 3.145
-8.888 -8.888 -8.888 -9.999 -8.888 -8.888 -9.999 -8.888
-8.888 -9.999 -8.888 -8.888 -8.888 -8.888 -9.999 -8.888
-8.888 -8.888 -8.888 -9.999 -9.999 -8.888 -8.888 -8.888
-8.888 -9.999 -8.888 -8.888 -9.999 -8.888 -8.888 -8.888
6879.443 234.304 6880.443 235.304 6878.443 235.304 6879.443 234.304
2016.201 6201.620 16.201 62.016 2.016 201.620 16.201 62.016
-8773.739 -2681.982 6463.247 -2337.566 -9103.673 -4812.165 -8773.739 -2681.982
-1273.439 -9539.077 -9457.182 -9843.786 -619.195 -5345.009 -1273.439 -9539.077
-6198.173 -9851.355 -2891.300 1239.308 -5511.323 3100.294 -2891.300 1239.308
-3168.457 -813.605 -6865.754 -5952.822 -3168.457 -813.605 -5521.761 2908.369
-293.234 2406.443 -203.392 2948.493 2039.201 -767.697 -203.392 2948.493
-2.120 -10.728 -109.893 -230.084 -2.120 -10.728 8.773 12.356
-7112.071 2028.500 -4245.662 2416.511 -5096.902 6822.833 -7112.071 2028.500', '1.000 0.000
-2.500 -2.500
0.151 -0.398
-9.999 -9.999
-9.999 -9.999
-9.999 -9.999
-9.999 -9.999
6879.443 236.304
2002.016 6341.224
6133.313 -4467.749
-8802.938 -5649.718
-8818.196 -7990.369
-9219.058 -2230.848
1949.359 -1309.747
-99.000 -207.000
-2230.493 7210.844');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (29, 10252, 'Common Permutation', '10252 - Common Permutation', 'https://onlinejudge.org/external/102/p10252.pdf', 2, '//uva10252
#include <iostream>
using namespace std;
 
string a, b;
int cnta[26], cntb[26];
 
int main() {
    while (cin >> a >> b){
        for (int i = 0; i < 26; i++){
            cnta[i] = 0;
            cntb[i] = 0;
        }
        for (int i = 0; i < a.length(); i++){
            cnta[a[i]-\'a\']++;
        }
        for (int i = 0; i < b.length(); i++){
            cntb[b[i]-\'a\']++;
        }
        for (int i = 0; i < 26; i++){
            for (int j = min(cnta[i], cntb[i]); j > 0; j--){
                cout << (char)(\'a\'+i);
            }
        }
        cout << \"\\n\";
    }
}', 'pretty
women
walking
down
the
street', 'e
nw
et', '未考過此題', '未考過此題', '未考過此題', '未考過此題');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (30, 10268, '498’', '10268 - 498’', 'https://onlinejudge.org/external/102/p10268.pdf', 1, '//uva10268
#include <bits/stdc++.h>

using namespace std;

int main() {

    long long int x, x1, temp;
    char c;
    vector<long long int> a;

    while (scanf(\"%lld\",&x)!=EOF) {
        while (scanf(\"%lld%c\",&temp, &c)) {
            if (c!=\' \')
                break;
            a.push_back(temp);
        }
        temp = 0, x1 = 1;
        for (int i = a.size()-1, j = 1; i>=0; i--, j++)
            temp+= a[i]*j*x1, x1*= x;
        printf(\"%lld\\n\", temp);
        a.clear();
    }
    return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '7
1 -1
2
1 1 1
2
1 -3 -1
0
-3 -4 3 -2
3
1 -2 3
2
-1 4 -4
-3
-4 -3
5
-5 3 -2
2
1 -4 5
6
8 5 -4
-3
-1 1 -4
-1
-5 -1 8 -7 0 9 -9 9 -6 -4 6
2
-5 4 -3 5 1 4
6
-4 5 -3 -1 -3 -1 3 -3
-4
-6 -2 -1 3 2 1
3
-1 -7 1 5 -1
6
-10 -3 -6 -5 2
-3
-7 7 -4 -2 -9 -1 -8
2
-1 1 7 1 -10 3
5
7 -1 1 10 11 -5 -6 -1 -2 -6 -8 1
-2
-2 -9 6 -11 6 -12
-6
-6 7 4 3 10 5 1 -9 -3 -1 -10
-1
-11 4 3 8 13 4 2
-1
1 -8 -5 0 -6 -6 5 6 -1 1 2 10 -10 10 2 -10 3 -8 11 6 11 -4 -9 -11
7
7 6 7 -5 11 8 7 -9 -6
11
10 -14 6 -6 -2 2
-3
-7 -9 -4 -14 13 7 -7 -2 -9 1 11
2
8 -5 -12 -10 -1 14 14 8 5 -15 -1 -7 3 12
3
-2 -4 -9 -16 -14 -13', '1
5
1
3
4
0
-4
-47
0
101
7
44
-287
-1093725
-7238
-286
-9041
13472
30
743277407
250
702063431
76
-26
51721892
659558
829549
136459
-1595', '0
-2 -1 -3
4
2 -3 -1
2
-5 1 -2 -3 -4
4
3 0 2 -5 4
-5
-3 4 -2 -3 5 2
-3
-3 -5 -3 0 1 2 -3 0
-2
4 -6 2 2 4
7
1 -1 -5 0
2
-8 1 -7 -2 -8 3 1 -2 -4
2
3 -1 -2 1 6 -5 8 7 -7 4
1
-2 8 3 3 0
1
7 0 -8 6 -7 3
-1
-1 7 -3 3 -8
-6
-5 0 -10 10 0 -1 -3 -3 5 -2 -8
3
4 1 -11 4 -5 -7 1
5
-6 7
10
10 -8
2
-7 -8 -6 -3 12 9
0
-5 7 7 6 -8 -4 8 9 2 -2 -6 -4 12 10 -9
9
-9 -2 3 -8 12 -5 0 12 5
1
2 11 -6 4 -3 11 -9 10 -12 2
2
-8 13 -7 12 11 -6 -8 -14 8 12 -11 7 -8 10 -4
3
-10 13 -5 4 8
10
12 -15
2
-15 2 5 -13 -14
7
8 -13 -14 -16 -10 4 -14 -12
6
-6 -8 6 5 -9 -8 2
3
-9 8 -5 -10 -1 11 -6 -14 7 6 -11
-1
7 16 5 -13 9 3 -11 7 2 -17 5 1 3 6 -2 -16 -17 0 -14 14 -14 10 -10 13 2', '-1
13
-159
779
-11490
-9222
-206
128
-9466
5621
25
16
34
529541326
5120
-6
10
-888
10
-350979711
98
-231906
-755
12
-449
5085948
-326168
-1435569
-18');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (31, 10409, 'Die Game', '10409 - Die Game', 'https://onlinejudge.org/external/104/p10409.pdf', 1, '//uva10409
#include <iostream>
#include <string>
using namespace std;

int main() {
	int m;
	while (cin >> m){
		if (m <= 0)
			break;
		int u = 1, n = 2, w = 3, e = 4, s = 5, o = 6;
		for (int i = 0; i < m; i++){
			string stg;

			int t;
			cin >> stg;
			switch (stg[0]){
				case \'n\':
					t = u;
					u = s;
					s = o;
					o = n;
					n = t;
					break;
				case \'s\':
					t = u;
					u = n;
					n = o;
					o = s;
					s = t;
					break;
				case \'e\':
					t = u;
					u = w;
					w = o;
					o = e;
					e = t;
					break;
				case \'w\':
					t = u;
					u = e;
					e = o;
					o = w;
					w = t;
					break;
			}
		}
		cout << u << endl;
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '1
north
3
north
east
south
1
north
1
east
1
south
1
west
5
north
south
east
west
south
2
south
east
2
south
west
2
north
north
3
east
east
east
4
east
east
south
west
10
east
west
east
north
north
west
south
north
north
west
1000
north
west
south
east
east
east
west
north
west
south
east
south
east
south
east
north
east
east
west
north
east
east
south
east
south
west
west
east
east
north
north
east
north
north
north
south
east
south
east
west
east
north
north
south
north
west
south
north
east
south
west
west
north
south
south
north
north
south
east
west
south
north
east
south
south
south
east
south
east
west
north
north
east
north
east
south
south
east
south
east
north
north
east
south
west
west
south
south
east
south
east
south
west
south
south
south
north
east
east
west
north
south
south
east
east
west
south
north
east
south
east
east
west
west
north
west
north
west
south
east
west
west
south
west
north
west
south
east
north
east
north
north
south
east
west
south
east
south
west
west
north
north
west
south
west
east
east
north
west
south
north
south
north
south
east
east
south
north
east
north
west
north
west
east
west
north
east
north
south
west
west
north
east
east
north
west
north
north
west
east
south
west
north
east
west
west
east
east
south
east
west
east
south
north
south
north
north
north
north
east
north
south
south
north
south
east
north
south
west
south
east
east
north
west
north
south
east
south
east
west
east
west
north
north
west
north
south
west
east
west
north
east
south
west
east
north
west
north
south
west
east
west
north
north
east
north
north
east
east
west
south
south
north
west
east
east
north
east
west
south
south
east
south
west
west
north
north
east
north
south
north
south
north
east
east
west
north
west
east
west
east
north
west
west
east
east
north
north
east
east
north
south
south
east
west
west
east
north
north
south
south
east
west
east
east
east
west
west
north
west
east
south
west
east
east
east
north
north
north
north
north
west
east
west
north
south
west
west
east
south
west
west
south
west
south
west
north
west
west
east
south
north
east
north
south
south
west
east
north
west
south
west
west
north
west
north
south
west
east
west
west
south
north
east
east
south
west
north
west
west
east
south
west
west
west
east
east
north
north
west
west
south
north
west
west
west
east
north
south
west
east
west
south
west
south
west
north
south
south
north
south
south
south
north
north
west
south
west
north
south
south
north
east
south
south
north
east
north
south
south
west
north
north
west
east
north
north
south
west
west
east
east
west
north
north
south
west
north
south
south
south
east
south
south
west
south
north
north
west
west
east
east
north
south
north
east
south
south
east
east
north
north
west
east
south
west
north
west
south
west
north
south
west
east
north
west
east
west
south
west
west
east
east
west
west
south
north
north
west
east
north
south
north
west
east
south
north
south
south
south
north
west
east
south
west
south
west
west
east
east
north
east
east
south
east
west
north
east
north
south
east
west
south
south
west
south
west
west
west
west
east
south
north
south
west
south
south
south
east
south
west
south
south
west
west
south
north
north
east
south
north
west
east
north
north
south
west
north
west
south
north
north
west
west
north
west
south
south
north
west
east
east
east
north
north
east
east
west
east
east
west
north
north
east
west
east
west
north
south
north
south
west
north
south
south
south
north
west
north
west
west
south
south
south
west
north
south
west
north
west
west
east
west
east
north
south
south
north
east
south
east
south
west
west
west
west
west
north
south
south
east
west
north
west
east
south
north
north
east
north
north
west
west
north
west
north
north
west
north
west
east
east
east
east
south
east
south
east
north
south
east
east
west
east
south
north
east
south
north
south
north
east
north
south
east
west
west
north
north
north
south
west
west
east
south
south
south
east
south
east
west
east
north
east
south
north
south
north
east
north
west
east
east
south
east
north
south
west
east
west
north
west
east
north
north
east
west
north
north
south
east
east
west
west
west
west
north
south
south
west
south
west
north
south
east
south
west
east
north
west
south
north
north
south
east
north
south
south
south
north
north
south
west
east
west
west
south
east
east
east
north
south
east
east
east
north
west
east
east
west
north
north
east
north
east
east
east
south
south
east
east
north
east
east
east
west
east
north
north
north
south
north
east
west
east
north
south
north
west
north
south
north
north
east
south
west
east
west
east
north
north
north
east
south
east
north
south
south
west
west
north
east
north
west
west
south
west
north
south
north
north
west
south
west
west
east
north
north
east
south
west
north
west
south
west
east
south
west
south
north
south
west
north
north
west
north
east
south
south
east
north
south
south
east
east
east
south
south
east
north
west
north
north
east
west
north
east
south
south
east
west
east
south
east
north
south
south
west
north
east
west
south
south
east
east
west
south
south
south
north
west
west
west
east
west
west
west
east
west
south
north
west
north
south
west
south
south
north
east
north
south
east
west
west
south
south
east
east
west
west
south
east
west
north
south
west
east
north
north
south
north
north
north
east
north
east
north
south
west
south
west
east
south
south
south
west
east
south
south
west
east
west
east
north
east
north
north
west
north
east
west
west
south
south
west
east
south
north
east
south
north
west
north
west
north
north
east
west
north
north
south
north
west
east
south
east
north
west
east
west
0', '5
1
5
3
2
4
2
3
4
6
4
3
3
2', '2
north
east
1
north
2
south
south
2
west
south
5
east
north
south
west
west
2
east
south
4
south
west
north
south
5
north
north
east
east
east
3
west
west
west
8
east
east
south
west
east
east
south
west
13
north
west
north
east
south
north
east
west
north
west
north
north
west
1000
west
west
south
south
south
south
east
south
north
west
west
west
north
east
west
east
east
east
east
west
east
east
south
south
east
south
west
north
north
south
west
west
south
east
south
east
north
west
south
east
east
east
south
north
south
east
south
south
west
south
west
north
west
west
south
south
west
south
south
south
north
west
west
south
west
north
south
north
north
south
south
west
west
south
north
west
south
west
north
west
east
west
south
south
south
east
east
west
north
east
west
west
west
west
west
east
north
east
north
east
south
west
north
east
south
north
north
north
north
south
east
east
south
west
west
north
west
west
east
south
south
south
north
east
east
east
east
south
south
west
west
north
west
south
north
west
north
north
west
east
west
south
east
north
west
south
east
west
west
east
south
south
east
south
north
south
east
east
north
west
east
east
east
north
south
west
east
south
west
south
south
west
west
north
east
north
north
east
west
west
north
west
west
west
north
south
north
east
south
east
south
east
east
north
north
west
east
south
east
east
north
east
south
south
north
east
east
east
east
north
west
north
west
east
south
south
south
west
south
west
west
east
west
east
north
east
east
east
east
west
west
south
south
west
west
south
west
west
east
west
north
north
north
south
south
west
west
west
south
south
north
south
west
east
east
west
east
south
west
west
east
south
east
south
east
west
north
west
west
south
north
north
east
west
south
north
south
west
south
east
south
north
north
south
south
east
south
south
north
west
north
east
north
west
east
east
east
west
north
east
south
north
north
west
north
north
west
west
south
south
east
east
south
north
south
south
west
east
west
north
west
west
south
east
west
north
north
west
north
north
north
north
west
east
south
east
west
south
south
west
west
west
west
east
north
south
north
west
west
east
north
south
west
west
west
west
north
south
north
west
north
west
west
west
east
west
west
east
west
north
north
south
east
north
north
south
east
east
east
east
north
east
west
east
north
east
south
east
east
east
west
north
north
west
south
north
west
south
east
east
north
east
east
west
west
south
north
south
west
west
north
north
west
west
south
east
north
north
north
west
east
north
west
east
north
west
west
east
east
east
south
west
east
north
north
south
south
east
west
west
south
west
west
west
south
west
east
east
south
north
west
north
east
west
north
north
north
north
east
west
east
west
west
south
north
north
north
east
north
north
east
north
east
east
south
north
north
west
west
east
north
east
east
north
north
east
south
west
east
west
west
south
west
south
north
east
east
north
north
north
south
west
south
north
south
north
south
east
south
south
south
west
south
south
east
west
west
south
east
west
south
south
west
south
north
east
west
south
east
west
east
east
west
west
west
west
east
east
west
west
south
south
north
north
east
south
east
east
north
south
north
east
north
south
east
south
north
south
north
west
west
east
south
north
north
north
south
north
north
east
south
west
north
north
east
west
east
south
south
east
east
east
east
south
west
west
south
west
east
north
west
east
south
east
west
east
west
south
west
north
south
east
south
west
south
north
west
east
north
north
east
south
east
east
north
south
north
north
north
north
south
west
south
east
east
west
east
west
south
east
south
west
west
south
west
west
west
east
west
north
north
south
north
south
north
south
north
west
south
east
south
south
west
north
north
west
west
north
east
west
south
east
east
south
west
east
north
east
north
west
west
north
south
west
south
north
south
south
south
south
west
east
east
east
south
east
east
south
east
south
south
south
west
south
west
west
west
east
north
south
west
south
west
north
north
south
north
south
east
east
south
south
east
north
west
west
west
south
west
east
south
south
east
east
east
north
north
north
west
east
north
west
west
north
west
east
north
east
east
south
south
east
east
east
north
west
west
south
east
east
south
south
west
east
south
west
south
west
north
east
south
north
west
south
south
east
west
south
west
north
north
east
north
south
east
west
north
south
east
north
west
south
north
west
north
south
south
south
east
west
west
north
north
west
south
east
west
west
east
east
west
south
south
east
north
south
south
east
north
north
west
north
north
east
north
east
east
west
south
south
east
north
east
west
east
south
south
west
west
south
east
south
east
north
west
west
south
west
west
south
north
south
south
south
north
south
north
east
south
south
east
south
east
east
west
west
west
south
west
west
south
north
north
south
west
west
south
north
west
west
south
north
east
west
west
south
north
east
north
east
north
north
south
west
east
south
west
east
north
west
south
west
east
east
south
west
east
east
east
east
north
east
west
south
west
south
north
east
west
north
north
west
north
south
west
west
south
north
south
south
west
north
north
west
east
west
east
south
west
east
south
west
east
east
south
east
south
north
north
north
west
west
north
north
east
west
east
south
east
west
west
south
east
east
south
east
west
north
north
north
west
south
west
west
west
north
west
east
east
south
north
west
south
north
south
west
east
south
west
west
south
south
west
east
north
east
east
north
north
east
west
east
north
east
west
west
west
north
south
north
0', '3
5
6
2
4
2
4
4
3
2
4
1');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (32, 10415, 'Eb Alto Saxophone Player', '10415 - Eb Alto Saxophone Player', 'https://onlinejudge.org/external/104/p10415.pdf', 1, '//uva10415
#include<bits/stdc++.h>
using namespace std;
int main(){
    int t;
    cin>>t;
    string line;
    int finger[11],a[11];
    map<char,vector<int>>mp;
    mp[\'c\']={0,1,1,1,0,0,1,1,1,1};
    mp[\'d\']={0,1,1,1,0,0,1,1,1,0};
    mp[\'e\']={0,1,1,1,0,0,1,1,0,0};
    mp[\'f\']={0,1,1,1,0,0,1,0,0,0};
    mp[\'g\']={0,1,1,1,0,0,0,0,0,0};
    mp[\'a\']={0,1,1,0,0,0,0,0,0,0};
    mp[\'b\']={0,1,0,0,0,0,0,0,0,0};
    mp[\'C\']={0,0,1,0,0,0,0,0,0,0};
    mp[\'D\']={1,1,1,1,0,0,1,1,1,0};
    mp[\'E\']={1,1,1,1,0,0,1,1,0,0};
    mp[\'F\']={1,1,1,1,0,0,1,0,0,0};
    mp[\'G\']={1,1,1,1,0,0,0,0,0,0};
    mp[\'A\']={1,1,1,0,0,0,0,0,0,0};
    mp[\'B\']={1,1,0,0,0,0,0,0,0,0};
    cin.ignore();
    while(t--){
        getline(cin,line);
        memset(finger,0,sizeof finger);
        memset(a,0,sizeof a);
        for(int i=0;i<line.length();i++){
            for(int j=0;j<10;j++){
                if(mp[line[i]][j]==1){
                    if(a[j]==1){
                        continue;
                    }
                    else{
                        finger[j]++;
                        a[j]=1;
                    }
                }
                else{
                    a[j]=0;
                }
            }
        }
        for(int i=0;i<10;i++){
            if(i){
                cout<<\" \";
            }
            cout<<finger[i];
        }
        cout<<\"\\n\";
    }
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '19
cdefgab
BAGFEDC
CbCaDCbCbCCbCbabCCbCbabae
B
D
g
e
d
CbCbCb
bbbbbbbbbbbbbbbbbbbbbbbbb
ABCDEFGabcdefg
BAAGFFfdcbcdeadfbcEDCbabbabbebadbbbababABABBABAGBBBBBGEaEDEDEbEDdadcddbdeeeeddeabdddddDDEEE
ccccCCdccaccacccccaaacccc
cacacaaBBBBcCbbbbBAAGGGGG
GFGFGGaaaaFFgGgGbcdefgabbbbbbbbbbbbb
cccccccccbbbbbbbbbaaaaaaaaaaa
AAACBDGcbabcggdfgeefgggggggggcbbbbbbbabbbbbbbbbbbbbAAAAAAAAAAAAAAAAAAAAAAGGGGGGGGGGGGGGGGGGfdfabdgcfFDFAGGFADDDACBBBBCBBBBBCGGFDgggadfefcdaadadeadadadadadaddadaddadadadadaddadadaaddaddaabbgdffgfdb
AAACBDGcbabcggdfgeefggggggBBBCGGFDgggadfefcdaadadeadadadadadaddadaddadadadadaddadadaaddaddaabbgdffgfdbgggcbbbbggggdggggggdfdfdgdfdgddfdfggabcbFGGGGGGGGGGGGGGGGfdfabdgcfFDFAGGFADDDACBBBBCBB
AAACBDGcbabcggdfgeefggggggBBBCGGFDgggadfefcdaadadeadadadadadaddadaddadadadadaddadadaaddaddaabbcccbbbbbbbbggcbbbbggggdgggggbdgcfFDFAGGFAdfdfggabcbFGGGGGGGGGGGGGGGGfdfabdgcfFDFAGGFABCBBgbcgddfg', '0 1 1 1 0 0 1 1 1 1
1 1 1 1 0 0 1 1 1 0
1 8 10 2 0 0 2 2 1 0
1 1 0 0 0 0 0 0 0 0
1 1 1 1 0 0 1 1 1 0
0 1 1 1 0 0 0 0 0 0
0 1 1 1 0 0 1 1 0 0
0 1 1 1 0 0 1 1 1 0
0 3 3 0 0 0 0 0 0 0
0 1 0 0 0 0 0 0 0 0
2 2 3 2 0 0 2 2 2 1
6 2 17 13 0 0 12 12 13 4
0 2 1 5 0 0 5 5 5 5
2 2 3 5 0 0 4 4 4 4
4 1 2 3 0 0 4 1 1 1
0 1 2 1 0 0 1 1 1 1
7 5 10 28 0 0 34 36 34 5
8 5 12 31 0 0 40 45 43 6
8 4 15 35 0 0 41 43 41 9', '15
cdefgabdbdgg
BAGFEdgffDC
CbCaDCAGDFEFbCbCCbCbabCCbCbabae
cCcCcCcCcCcCcbgbgbadCcAB
AAAACDEFgabcdefGAAAAAAAAbabcbcbbcccaDGDCCCCCCCC
cbabcGDDGGGDACBEDGAbggdffdggd
ACGCGACagcgagc
cdefdecdefdcedfbCbC
AAAAAAAAAAAAAAAAAAAAAAAAAA
dDBbGAFDEgg
AAACBcdefgabdfgeefgggggggggcbbbbbbbabbbbbbbbbbbbbAAAAAAAAcdefgabAAAAAAAGGGGGGGGGGGGGGGGGGfdfabdgcfFDFAGGFADDDACBBBBCBBBBBCGGFDgggadfefcdaadadeadadadadadaddadaddadadadadaddadadaaddaddaabbgdffgfdb
AAACBDGcbacdefgabfgeefgggggggggcbbbbbbbabbbbbbbbbbbbbAAAAAcdefgabAAAAAAGGGGGGGGGGGGGGGGGGfdfabdgcfFDFAGgggcbbbbggggdggggggdfdfdgdfdgddfdfggabcbFGGGGGGGGGGGGGGGGfdfabdgcfFDFAGGFADcdefgabBB
AAACBDGcbabcggdfgeefAAAAAAAAAAAAaadadeadadaAAAAAAAGGGGGGGdadaddadadaaddaddaabbcccbbbbbbbbggcbbbbggggdggggcdefgabGFAdfdfggabcbFGGGGGGGGGGGGGGGGfdfabdgcfFDFAGGFABCBBgbcgddfg
BGGFFEFAEFEDFAFFACbbdgeffEADFgbbegfdbcgfedagdbgf
ggdffgdggddfgdgfgaedeaddcbcgdefADEFDEADGGFBCGFFDgGDGGgGfdgdggdaead', '0 1 3 3 0 0 3 3 3 1
2 1 1 1 0 0 2 2 2 0
2 8 10 3 0 0 3 4 2 0
1 8 4 11 0 0 9 9 9 8
4 2 6 6 0 0 7 7 7 4
2 2 5 4 0 0 7 8 8 2
3 4 1 4 0 0 2 2 2 2
0 2 3 1 0 0 1 3 5 3
1 1 1 0 0 0 0 0 0 0
2 1 2 3 0 0 2 2 2 0
8 5 10 29 0 0 33 35 33 5
8 2 12 13 0 0 22 25 24 9
8 3 14 24 0 0 30 29 28 8
2 2 5 9 0 0 12 12 7 1
4 2 3 9 0 0 19 18 17 2');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (33, 10420, 'List of Conquests', '10420 - List of Conquests', 'https://onlinejudge.org/external/104/p10420.pdf', 1, '//uva10420
#include<iostream>
#include<map>
using namespace std;
int main(){
   map<string,int> count;
   map<string,int>::iterator iter;
   string first_s;
   char others[76]={0};
   int n;
   cin>>n;
   cin.ignore();
   while (n--){
      cin>>first_s;
      count[first_s]++;
      cin.getline(others,76);
   }
for (iter=count.begin(); iter!=count.end();iter++){
      cout<<iter->first<<\" \";
      cout<<iter->second<<endl;
   }
   return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '20
Spain Donna Elvira
England Jane Doe
Spain Donna Anna
Netherlands Myrthe Polder
America Michelle LaVaughn Robinson Obama
England Theresa May
Spain Sandra Gallardo
Canada Jenna Agnew
America Oprah Winfrey
Spain Marta Nicart
Spain Gemma Gili
Germany Johanna Hegering
Canada Rebecca Gilles
Switzerland Jana Bachmann
England Donna Langley
India Roshni Nadar Malhotra
Switzerland Martina Dickenmann
Australia Gina Rinehart
Germany Meike Hegering
Canada Kaila Zadorsky', 'America 2
Australia 1
Canada 3
England 3
Germany 2
India 1
Netherlands 1
Spain 5
Switzerland 2', '90
America Phebe Novakovic
Portugal Diana Silva
Germany Sandra Teschke
Malaysia Tengku Anis Tengku
Taiwan Chuang Chia chia
Afghanistan Rula Ghani
Spain Gemma Mengual
Iraq Samira Talfah
Syria Asma Akhras
America Priscilla Chan
Norway Ingrid Thorisdottir
America Dana Walden
Japan Himawari Okoye
Spain Alba Maria Rodriguez
Norway Maren Minde
Turkey Bahar Sarica
America Diana Trump
France Charlotte Cissoko
America Jessica Jones
France Sandrine Laurent
Turkey Yasemin Sanders
Norway Cecilie Graham Hansen
America Jessica Redstone
Turkey Birsel Alben
America Jessica Brewer
Korea Jessica Sooyoun Jung
Singapore Ho Ching
Myanmar Henry Van Suu
Singapore Chew Poh Yim
Norway Ingvild Thorsnes
Russia Anastasia Ermakova
Netherlands Laura Buijs
France Marion Torrent
Japan Evelyn Nemoto
Germany Franzisca Hauke
Taiwan Chi Ling Lin
Norway Maria Haug
England Katie Bell
Taiwan Tzu Ying Tai
England Hannah Abbott
Turkey Esmeral Nevlin
Germany Miriam Gnabry
Australia Sam Vanna
Belgium Elien Van Wynendaele
Germany Katharina Otte
Poland Maria Szymborska
Belgium Tine De Caigny
England Ginevra Weasley
Germany Nike Lorenz
England Alicia Spinnet
England Susan Bones
Germany Franziska Weber
Belgium Yana Biesmans
Australia Elise Ibini
Italy Aurora Boattin
Turkey Yasemin Ural
Norway Vilde Risa
Spain Paola Tirados
Russia Anna Shorina
France Sonia Georges
Norway Isabell Moe Wold
Netherlands Celeste Knip
Romania Iuliana Oprea
Russia Ovchinnikova
Norway Maren Hjelmseth
Australia Laura Polkinghorne
Italy Valentina Tarenzi
Norway Tuva Utland
Russia Elvira Khasyanova
Australia Lydia Williams
Russia Svetlana Kuzhela
Turkey Esmeral Cora
Denmark Hedvig Andersen
Belgium Diede Lemey
Norway Linda Mjelde
Australia Katrina Dumont
France Sandie Mbock Bathy
France Ouleymata Philippe
Netherlands Britt Koolhaas
Belgium Nicky Gorp
Italy Cristiana Sabatino
Spain Gisela Corral
Russia Maria Kuzhela
Russia Natalia Ishchenko
Denmark Anne Rasmussen
Spain Irina Rodriguez
Norway Ingrid Stoltenberg
Portugal Tatiana Pinto
Italy Alia Adami
Finland Brita Haukio', 'Afghanistan 1
America 7
Australia 5
Belgium 5
Denmark 2
England 5
Finland 1
France 6
Germany 6
Iraq 1
Italy 4
Japan 2
Korea 1
Malaysia 1
Myanmar 1
Netherlands 3
Norway 11
Poland 1
Portugal 2
Romania 1
Russia 7
Singapore 2
Spain 5
Syria 1
Taiwan 3
Turkey 6');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (34, 10642, 'Can You Solve It?', '10642 - Can You Solve It?', 'https://onlinejudge.org/external/106/p10642.pdf', 1, '//uva10642
#include <iostream>

#define ll long long int

using namespace std;
void solve(int i) {
    long long int x0, y0, x1, y1, s0, s1;
    cin >> x0 >> y0 >> x1 >> y1;
    cout << \"Case \" << i << \": \";
    s0 = x0 + y0 + (x0 + y0 - 1) * (x0 + y0) / 2 + x0;
    s1 = x1 + y1 + (x1 + y1 - 1) * (x1 + y1) / 2 + x1;
    cout << s1 - s0 << endl;
}

int main() {
    int t;
    cin >> t;
    for (int i = 1; i <= t; i++) {
        solve(i);
    }
    return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '24
0 0 0 1
0 0 1 0
0 0 0 2
1 2 2 1
3 0 0 4
0 3 4 0
1 0 0 4
1 2 3 4
1 1 5 5
2 3 4 5
1 3 9 10
3 7 8 14
24 0 91 14
14 29 87 26
24 50 74 8
48 1 89 3
92 36 29 100
122 123 834 283
0 1 99999 99999
28 13 84191 97359
1634 2149 6373 8466 
1727 4933 4557 4918 
1635 6882 7819 8169 
130 940 15555 57305', 'Case 1: 1
Case 2: 2
Case 3: 3
Case 4: 1
Case 5: 1
Case 6: 8
Case 7: 8
Case 8: 24
Case 9: 56
Case 10: 32
Case 11: 188
Case 12: 203
Case 13: 5332
Case 14: 5568
Case 15: 678
Case 16: 3094
Case 17: 66
Case 18: 594980
Case 19: 19999799999
Case 20: 16480375327
Case 21: 102952683
Case 22: 22714250
Case 23: 91548347
Case 24: 2653768670', '22
1 2 4 5
2 3 6 7
4 5 8 10
12 2 231 209
33 7 24 36
14 84 97 47
14 32 69 18
12 53 35 72
23 92 393 1920
123 343 435 543
23 3234 12323 34343
789  8169 16235 6882
414  5675 72175 1472
15 7 23 81
17 58 13 63
223 333 444 6045
23 12 2132 213
92 39 3445 32024
5483 97290 94346 71598
1 2 99999 99999
3142 526 73102 63895
3554 7802 21753 94326', 'Case 1: 42
Case 2: 80
Case 3: 130
Case 4: 97134
Case 5: 1001
Case 6: 5672
Case 7: 2802
Case 8: 3656
Case 9: 2669841
Case 10: 370232
Case 11: 1083587758
Case 12: 227097488
Case 13: 2693507884
Case 14: 5215
Case 15: 72
Case 16: 20902180
Case 17: 2752164
Case 18: 629037422
Case 19: 8487681252
Case 20: 19999799993
Case 21: 9377498517
Case 22: 6672758313');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (35, 10783, 'Odd Sum', '10783 - Odd Sum', 'https://onlinejudge.org/external/107/p10783.pdf', 1, '//uva10783
#include <iostream>

using namespace std;

int main() {
	int t, ti = 0;
	cin >> t;
	int arr[101] = {};
	for(int i = 1; i < 101; ++i) {
		if(i % 2 == 1)
			arr[i] = i;
		arr[i] += arr[i-1];
	}
	while(ti++ < t) {
		int a, b;
		cin >> a >> b;

		if(a == 0)
			a = 1;

		cout << \"Case \" << ti << \": \" << arr[b] - arr[a-1] << endl;
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '20
1
5
3
5
50
92
2
31
11
76
29
35
29
62
51
94
37
91
21
63
28
98
50
60
43
86
0
1
0
0
99
100
100
100
1
100
19
32
7
10', 'Case 1: 9
Case 2: 8
Case 3: 1491
Case 4: 255
Case 5: 1419
Case 6: 128
Case 7: 765
Case 8: 1584
Case 9: 1792
Case 10: 924
Case 11: 2205
Case 12: 275
Case 13: 1408
Case 14: 1
Case 15: 0
Case 16: 99
Case 17: 0
Case 18: 2500
Case 19: 175
Case 20: 16', '20
0
1
0
0
99
100
100
100
1
100
7
84
87
92
42
73
2
95
16
53
78
89
5
10
11
46
25
50
74
79
68
96
9
47
25
74
25
30
25
66', 'Case 1: 1
Case 2: 0
Case 3: 99
Case 4: 0
Case 5: 2500
Case 6: 1755
Case 7: 267
Case 8: 928
Case 9: 2303
Case 10: 665
Case 11: 504
Case 12: 21
Case 13: 504
Case 14: 481
Case 15: 231
Case 16: 1148
Case 17: 560
Case 18: 1225
Case 19: 81
Case 20: 945');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (36, 10812, 'Beat the Spread!', '10812 - Beat the Spread!', 'https://onlinejudge.org/external/108/p10812.pdf', 1, '//uva10812
#include <iostream>
using namespace std;
 
int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    int T, s, d;
    cin >> T;
    while (T--){
        cin >> s >> d;
        if ((s + d) % 2 || s < d) cout << \"impossible\\n\";
        else {
            cout << (s+d)/2 << \" \" << (s-d)/2 << \"\\n\";
        }
    }
    return 0;
}', '4
40 20
20 40
5 1
100 1', '30 10
impossible
3 2
impossible', '未考過此題', '未考過此題', '未考過此題', '未考過此題');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (37, 10908, 'Largest Square', '10908 - Largest Square', 'https://onlinejudge.org/external/109/p10908.pdf', 1, '//uva10908
#include <iostream>
using namespace std;

int largestSquare(char grid[][101], int m, int n, int r, int c){
    int length = 1;

    while(1){

        // upper left corner, lower right corner 
        int ulx, uly, lrx, lry;

        ulx = r - length;
        uly = c - length;
        lrx = r + length;
        lry = c + length;

        // out of bound
        if( ulx < 0 || lrx >= m || uly < 0 || lry >= n )
            return length * 2 - 1;

        // top and down
        for(int i = ulx; i <= (r +length); i += length * 2){
            for(int j = uly; j <= lry; j++){
                if (grid[i][j] != grid[r][c])
                    return length * 2 - 1;
            }
        }

        // left and right
        for(int j = uly; j <= (c + length); j += length * 2){
            for(int i = ulx; i <= lrx; i++){
                if (grid[i][j] != grid[r][c])
                    return length * 2 - 1;
            }
        }
        length += 1;
    }
    
    return length * 2 - 1;
}


int main() {
    int t, m, n, q;
    cin >> t;
    while (t--){
        char grid[101][101] = {0};
        cin >> m >> n >> q;
        for (int i = 0; i < m; i++)
            for(int j = 0; j < n; j++)
                cin >> grid[i][j];

        int r, c;
        cout << m << \" \" << n << \" \" << q << \"\\n\";
        while (q--){
            cin >> r >> c;
            cout << largestSquare(grid, m, n, r, c) << \"\\n\";
        }
    }
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '12
7 10 4
abbbaaaaaa
abbbaaaaaa
abbbaaaaaa
aaaaaaaaaa
aaaaaaaaaa
aaccaaaaaa
aaccaaaaaa
1 2
2 4
4 6
5 2
10 10 3
aaaaaaaaaa
aaaaaaaaaa
aaaaaaaaaa
aaabbbaaaa
aaabbbaaaa
aaabbbaaaa
aaaaaaaaaa
aaaaaaaaaa
aaaaaaaaaa
aaaaaaaaaa
4 4
8 5
5 3
7 7 1
aaaxaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
3 3
7 23 3
.......................
..ccccc..ppppp..eeeee..
..c......p...p..e......
..c......ppppp..eeeee..
..c......p......e......
..ccccc..p......eeeee..
.......................
3 5
5 12
3 16
7 7 1
aaxaaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
3 3
7 7 1
aaxaaaa
aaxaaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
aaaaaaa
3 3
5 5 2
aabbc
aabbd
eeeff
eeeff
eeegh
1 2
3 1
6 5 2
sswss
sssss
sssss
sssss
sssss
ssssz
2 2
3 2
8 8 4
aaaaabbb
aaaaabbb
aaaaabbb
aaaccccc
aaaccccc
aaaccccc
aaaccccc
aaaccccc
5 5
3 3
1 2
2 1
12 3 4
aab
aaa
aaa
baa
aaa
aaa
aaa
aaa
baa
aaa
aaa
aab
1 1
4 1
7 1
10 1
1 1 1
t
0 0
99 99 16
paaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaacccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaacccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaccbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeeaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafafaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaggggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaggggggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaggggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhhaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
zaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaap
14 90
20 7
34 50
40 61
46 62
53 23
72 45
6 71
6 70
62 7
4 91
49 50
21 36
28 74
55 0
2 2', '7 10 4
3
1
5
1
10 10 3
3
3
1
7 7 1
5
7 23 3
3
3
1
7 7 1
5
7 7 1
3
5 5 2
1
3
6 5 2
3
3
8 8 4
5
1
3
3
12 3 4
1
1
1
1
1 1 1
1
99 99 16
17
15
51
45
33
1
1
5
5
15
9
39
43
39
1
3', '10
6 9 3
qqqqeqqqq
qqqqqqqqq
qqqqqqqqq
qqqqqqqzq
qqqqqqqqq
qqqqqqqqq
2 2
2 6
1 1 
7 7 3
xxxxxxx
xxxxxxx
xxxxxxx
xxxxxxx
xxxxxxx
xxxxxxx
xxxxxxx
3 3
2 2
2 3
6 6 3
******
****v*
******
******
******
******
3 2
2 3
1 4
4 4 3
1111
1111
1122
3322
1 1
2 2
3 1
5 5 1
ooxoo
oxxxo
xxxxx
oxxxo
ooxoo
2 2
11 11 3
jjjjjjjjjjj
jjjjjjjjjjj
jjjjjjjjijj
jjjjjjjjjjj
jjjjjjjjjjj
jjjjjjjjjjj
jjjjjjjjjjj
jjjjjjjjjjj
jjjjjjjjjjj
jjjjjjjjjjj
jjjjjjjjjjj
6 6
7 4
1 10
2 2 4
aa
aa
0 0
0 1
1 0
1 1
5 5 1
aaaaa
abbba
abcba
abbda
aaaaa
2 2
9 9 8
ttttttttz
tcttttttt
ttttttttt
ttttttttt
ttttttttt
ttttttttt
ttttttttt
ttttttttt
ttttttttt
4 4
5 5
1 7
0 0
3 5
2 7
5 4
4 5
100 100 20
paaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabbbbbbbaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaacccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaacccaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaccbaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeeaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeeaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeeaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaeeeeaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafafaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaggggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaggggggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaggggggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaggaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhhaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaahhhhhaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
zaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaap
80 25
87 73
90 14
46 62
53 23
72 45
6 71
6 70
62 7
4 91
49 50
0 0
65 21
95 90
40 40
76 33
21 36
28 74
55 0
2 2', '6 9 3
3
1
3
7 7 3
7
5
5
6 6 3
3
1
1
4 4 3
1
1
1
5 5 1
3
11 11 3
7
7
1
2 2 4
1
1
1
1
5 5 1
1
9 9 8
5
7
1
1
5
3
7
7
100 100 20
3
5
17
35
1
1
7
5
15
9
39
1
21
9
31
7
43
37
1
3');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (38, 10922, '2 the 9s', '10922 - 2 the 9s', 'https://onlinejudge.org/external/109/p10922.pdf', 1, '//uva10922
#include <iostream>
using namespace std;
 
int func(string s, int count){
    int temp = 0, total = 0;
    for (int i = 0; i < s.length(); i++){
        temp = s[i] - \'0\';
        total += temp;
    }
    count++;
    if (total == 9){
        return count;
    }else if(total < 9){
        return 0;
    }else{
        return func(to_string(total), count);
    }
}
int main(){
    int ans;
    string s;
    while (cin >> s){
        if (s == \"0\") break;
        ans = func(s, 0);
        if (ans == 0){
            cout << s << \" is not a multiple of 9.\\n\";
        }else{
            cout << s << \" is a multiple of 9 and has 9-degree \" << ans << \".\\n\";
        }
    }
}', '999999999999999999999
9
9999999999999999999999999999998
837
0', '999999999999999999999 is a multiple of 9 and has 9-degree 3.
9 is a multiple of 9 and has 9-degree 1.
9999999999999999999999999999998 is not a multiple of 9.
837 is a multiple of 9 and has 9-degree 2.', '999999999999999999999
9
9999999999999999999999999999998
18
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
101231456781231245678912310213245496879879412313032154987987984213012645978123456789123123154657981231032132457892120321546879812023134564879121021549879875102165487931231548792130215468789453120215467898951200212154878132021345678923123032146549879142103213456789798721320321564678465651320216548798745132023165468798798412120321546496821324654987913020216549687987986516545612302316549878945132023154687978951651322132023156487874212120214548787879879845150654987984502645948978974984552120261101231456781231245678912310213245496879879412313032154987987984213012645978123456789123123154657981231032132457892120321546879812023134564879121021549879875102165487931231548792130215468789453120215467898951200212154878132021345678923123032146549879142103213456789798721320321564678465651320216548798745132023165468798798412120321546496821324654987913020216549687987986516545612302316549878945132023154687978951651322132023156487874212120214548787879879845150654987984502645948978974984552120261
45454545454545454545454545454545454545
2014547891534112345648978915132134567892132154679879423132131
1245674897981231546549687987543513215446879879864135454878974651321345467879
987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321
1111111111111111111111111111111111112222222222222222222222222222222222222222222222233333333333333333333333333333333333333333344444444444444444444444444444444444444444444445555555555555555555555555555555555555555
125487121214571212154878
2358954789999
0', '999999999999999999999 is a multiple of 9 and has 9-degree 3.
9 is a multiple of 9 and has 9-degree 1.
9999999999999999999999999999998 is not a multiple of 9.
18 is a multiple of 9 and has 9-degree 1.
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 is not a multiple of 9.
101231456781231245678912310213245496879879412313032154987987984213012645978123456789123123154657981231032132457892120321546879812023134564879121021549879875102165487931231548792130215468789453120215467898951200212154878132021345678923123032146549879142103213456789798721320321564678465651320216548798745132023165468798798412120321546496821324654987913020216549687987986516545612302316549878945132023154687978951651322132023156487874212120214548787879879845150654987984502645948978974984552120261101231456781231245678912310213245496879879412313032154987987984213012645978123456789123123154657981231032132457892120321546879812023134564879121021549879875102165487931231548792130215468789453120215467898951200212154878132021345678923123032146549879142103213456789798721320321564678465651320216548798745132023165468798798412120321546496821324654987913020216549687987986516545612302316549878945132023154687978951651322132023156487874212120214548787879879845150654987984502645948978974984552120261 is not a multiple of 9.
45454545454545454545454545454545454545 is a multiple of 9 and has 9-degree 2.
2014547891534112345648978915132134567892132154679879423132131 is not a multiple of 9.
1245674897981231546549687987543513215446879879864135454878974651321345467879 is not a multiple of 9.
987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321987654321 is a multiple of 9 and has 9-degree 3.
1111111111111111111111111111111111112222222222222222222222222222222222222222222222233333333333333333333333333333333333333333344444444444444444444444444444444444444444444445555555555555555555555555555555555555555 is not a multiple of 9.
125487121214571212154878 is not a multiple of 9.
2358954789999 is not a multiple of 9.', '999999999999999999999
9
9999999999999999999999999999998
1853020188851841
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
111111111111111111111111111888888888888888888888888888
2147483647
555555555000000000
1298371298312612089641789134138795128753128972513987215938127512879512712698721123859712591827
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999
10
1441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441449
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789000000000000000000000000000000000000000000000000000000123456789
0', '999999999999999999999 is a multiple of 9 and has 9-degree 3.
9 is a multiple of 9 and has 9-degree 1.
9999999999999999999999999999998 is not a multiple of 9.
1853020188851841 is a multiple of 9 and has 9-degree 2.
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 is not a multiple of 9.
111111111111111111111111111888888888888888888888888888 is a multiple of 9 and has 9-degree 2.
2147483647 is not a multiple of 9.
555555555000000000 is a multiple of 9 and has 9-degree 2.
1298371298312612089641789134138795128753128972513987215938127512879512712698721123859712591827 is not a multiple of 9.
99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999 is a multiple of 9 and has 9-degree 3.
10 is not a multiple of 9.
1441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441441449 is a multiple of 9 and has 9-degree 3.
12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789000000000000000000000000000000000000000000000000000000123456789 is a multiple of 9 and has 9-degree 2.');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (39, 10929, 'You can say 11', '10929 - You can say 11', 'https://onlinejudge.org/external/109/p10929.pdf', 1, '//uva10929
#include <stdio.h>
#include <string.h>

int main() {
	char str[1005];
	int one, two, len, i, d;

	while(scanf(\"%s\", str) != EOF) {
		len = strlen(str);
		if(len == 1 && str[0] == \'0\')
			break;

		one = two = 0;
		for(i = 0; i < len; i+=2)
			one += (int)(str[i] - \'0\');
		for(i = 1; i < len; i+=2)
			two += (int)(str[i] - \'0\');

		if(one > two)
			d = one - two;
		else
			d = two - one;

		if(d % 11 == 0)
			printf(\"%s is a multiple of 11.\\n\", str);
		else
			printf(\"%s is not a multiple of 11.\\n\", str);
	}
	return 0;
}', '112233
30800
2937
323455693
5038297
112234
0011
00011
030800
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
0', '112233 is a multiple of 11.
30800 is a multiple of 11.
2937 is a multiple of 11.
323455693 is a multiple of 11.
5038297 is a multiple of 11.
112234 is not a multiple of 11.
0011 is a multiple of 11.
00011 is a multiple of 11.
030800 is a multiple of 11.
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111 is a multiple of 11.', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (40, 10931, 'Parity', '10931 - Parity', 'https://onlinejudge.org/external/109/p10931.pdf', 1, '//uva10931
#include <iostream>

const unsigned int MASK = 1<<31;

int main(){
  using namespace std;
  int input;
  while(cin >> input,input){
    cout << \"The parity of \";
    unsigned int mask = 1<<31;
    int count = 0;
    for(;mask&& !(mask&input);mask >>= 1);

    for(;mask;mask >>= 1){
      cout << 0 + !!(mask & input);
      count += !!(mask & input);
    }

   cout << \" is \" << count << \" (mod 2).\"<< endl;


  }
  return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '1
2
10
21
3
4
5
6
16
20
33
34
127
128
2388
2338
12329
28999
100000
200001
1209923
21340000
234020033
2147483647
2147483646
0', 'The parity of 1 is 1 (mod 2).
The parity of 10 is 1 (mod 2).
The parity of 1010 is 2 (mod 2).
The parity of 10101 is 3 (mod 2).
The parity of 11 is 2 (mod 2).
The parity of 100 is 1 (mod 2).
The parity of 101 is 2 (mod 2).
The parity of 110 is 2 (mod 2).
The parity of 10000 is 1 (mod 2).
The parity of 10100 is 2 (mod 2).
The parity of 100001 is 2 (mod 2).
The parity of 100010 is 2 (mod 2).
The parity of 1111111 is 7 (mod 2).
The parity of 10000000 is 1 (mod 2).
The parity of 100101010100 is 5 (mod 2).
The parity of 100100100010 is 4 (mod 2).
The parity of 11000000101001 is 5 (mod 2).
The parity of 111000101000111 is 8 (mod 2).
The parity of 11000011010100000 is 6 (mod 2).
The parity of 110000110101000001 is 7 (mod 2).
The parity of 100100111011001000011 is 10 (mod 2).
The parity of 1010001011001111101100000 is 12 (mod 2).
The parity of 1101111100101101110011000001 is 16 (mod 2).
The parity of 1111111111111111111111111111111 is 31 (mod 2).
The parity of 1111111111111111111111111111110 is 30 (mod 2).', '7
8
10
30
40
50
346
53
100
2234
1602
6034
50234
103001
200003
23434
123229
2899
100200
200201
1209233
2134020
23402033
214743647
0', 'The parity of 111 is 3 (mod 2).
The parity of 1000 is 1 (mod 2).
The parity of 1010 is 2 (mod 2).
The parity of 11110 is 4 (mod 2).
The parity of 101000 is 2 (mod 2).
The parity of 110010 is 3 (mod 2).
The parity of 101011010 is 5 (mod 2).
The parity of 110101 is 4 (mod 2).
The parity of 1100100 is 3 (mod 2).
The parity of 100010111010 is 6 (mod 2).
The parity of 11001000010 is 4 (mod 2).
The parity of 1011110010010 is 7 (mod 2).
The parity of 1100010000111010 is 7 (mod 2).
The parity of 11001001001011001 is 8 (mod 2).
The parity of 110000110101000011 is 8 (mod 2).
The parity of 101101110001010 is 8 (mod 2).
The parity of 11110000101011101 is 10 (mod 2).
The parity of 101101010011 is 7 (mod 2).
The parity of 11000011101101000 is 8 (mod 2).
The parity of 110000111000001001 is 7 (mod 2).
The parity of 100100111001110010001 is 10 (mod 2).
The parity of 1000001001000000000100 is 4 (mod 2).
The parity of 1011001010001011000110001 is 11 (mod 2).
The parity of 1100110011001011101001011111 is 17 (mod 2).');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (41, 11005, 'Cheapest Base', '11005 - Cheapest Base', 'https://onlinejudge.org/external/110/p11005.pdf', 1, '//uva11005
#include <iostream>
#include <cstring>
#include <cstdio>

using namespace std;

int f(int a, int b, int arr[], int &cnt) {
	int tmp[40] = {}, i;
	cnt = 0;
	while(a >= b) {
		tmp[cnt++] = a % b;
		a /= b;
	}
	if(a)
		tmp[cnt++] = a;
	for(i = 0; i < cnt; ++i)
		arr[cnt-i-1] = tmp[i];

	return 0;
}

int CalCost(int arr[], int cnt, int cost[]) {
	int sum = 0;
	for(int i = 0; i < cnt; ++i) {
		sum += cost[arr[i]];
	}

	return sum;
}

int main()
{
	int a, b, n, num, Min;
	int cost[40];
	int t, ti = 0;
	cin >> t;
	while(ti++ < t) {
		printf(\"Case %d:\\n\", ti);

		for(int i = 0; i < 36; ++i)
			cin >> cost[i];
		cin >> n;
		while(n--) {
			int arr[40] = {}, cnt = 0;
			int price[40] = {};

			cin >> num;
			Min = 999999999;
			for(b = 2; b <= 36; ++b) {
				f(num, b, arr, cnt);
				price[b] = CalCost(arr, cnt, cost);

				if(price[b] < Min)
					Min = price[b];
			}

			printf(\"Cheapest base(s) for number %d:\", num);
			for(b = 2; b <= 36; ++b) {
				if(price[b] == Min)
					printf(\" %d\", b);
			}
			printf(\"\\n\");
		}
		if(ti != t)
			printf(\"\\n\");
	}

	return 0;
}', '2
11 8 12 13 15 13 13 16 9
12 18 24 21 23 23 23 13 15
18 33 21 23 27 26 27 19 4
23 19 30 30 24 16 26 21 21
6
98329921
12345
800348
14
873645
873647
1 1 2 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
1 1 1 1 1 1 1 1 1
4
0
2
10
100', 'Case 1:
Cheapest base(s) for number 98329921: 24
Cheapest base(s) for number 12345: 31
Cheapest base(s) for number 800348: 31
Cheapest base(s) for number 14: 13
Cheapest base(s) for number 873645: 22
Cheapest base(s) for number 873647: 22

Case 2:
Cheapest base(s) for number 0: 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
Cheapest base(s) for number 2: 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
Cheapest base(s) for number 10: 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
Cheapest base(s) for number 100: 11 12 13 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (42, 11063, 'B2-Sequence', '11063 - B2-Sequence', 'https://onlinejudge.org/external/110/p11063.pdf', 1, '//uva11063
#include <stdio.h>

int main() {
	int b[100], n, i, j, t = 1, flag;
	int check[20001];

	while(scanf(\"%d\", &n) == 1)
	{
		flag = 1;
		for(i = 0; i < 20001; i++)
			check[i] = 0;
		for(i = 0; i < n; i++) {
			scanf(\"%d\", &b[i]);
			if(b[i] < 1)
				flag = 0;
		}

		for(i = 0; i < n; i++)
			for(j = i;j < n; j++) {
				if(check[b[i] + b[j]] || b[j] < b[i])
					flag = 0;
				else
					check[b[i] + b[j]]=1;
			}
		
		if(flag)
			printf(\"Case #%d: It is a B2-Sequence.\\n\\n\",t++);
		else
			printf(\"Case #%d: It is not a B2-Sequence.\\n\\n\",t++);
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '6
1 9 19 -1 45 70

5
1 2 3 4 4

4
7 8 9 10

3
1 3 2

2
9999 10000

6
1 9 19 45 70 150

100
42 109 143 143 212 236 314 372 434 498 503 548 629 656 717 808 903 945 972 1008 1099 1103 1105 1158 1250 1332 1353 1369 1387 1482 1529 1555 1626 1664 1733 1745 1812 1911 1946 2040 2043 2054 2076 2109 2182 2246 2287 2298 2351 2419 2466 2510 2572 2629 2666 2725 2748 2789 2818 2896 2912 2947 3037 3079 3167 3173 3213 3255 3319 3367 3413 3418 3508 3537 3607 3657 3663 3664 3757 3805 3834 3857 3941 3995 4051 4091 4157 4233 4264 4272 4316 4355 4381 4404 4441 4479 4497 4579 4608 4649 

99
36 111 191 262 324 339 346 351 411 506 515 542 624 675 706 770 780 788 803 890 979 1028 1086 1171 1231 1241 1265 1273 1366 1463 1546 1617 1692 1775 1856 1914 1999 2039 2125 2181 2217 2249 2278 2353 2381 2468 2553 2625 2673 2721 2741 2801 2801 2884 2891 2941 3031 3056 3076 3110 3122 3177 3197 3242 3267 3284 3303 3357 3359 3419 3497 3561 3588 3634 3718 3775 3857 3907 3987 4070 4255 4352 4397 4485 4520 4542 4570 4669 4677 4717 4728 4786 4881 4906 4961 4980 5069 5084 5167

100
15 28 97 162 201 210 262 307 400 431 506 556 592 687 771 858 898 985 985 1009 1058 1091 1165 1237 1328 1379 1425 1492 1510 1606 1633 1677 1695 1736 1800 1851 1930 1972 2060 2083 2174 2232 2311 2337 2429 2445 2515 2537 2596 2612 2695 2763 2832 2905 2984 3049 3055 3120 3169 3261 3320 3398 3469 3532 3620 3633 3730 3796 3873 3881 3949 3995 4083 4099 4156 4220 4292 4377 4420 4459 4495 4509 4555 4643 4723 4766 4851 4911 5006 5082 5107 5116 5208 5247 5265 5270 5308 5390 5429 5503', 'Case #1: It is not a B2-Sequence.

Case #2: It is not a B2-Sequence.

Case #3: It is not a B2-Sequence.

Case #4: It is not a B2-Sequence.

Case #5: It is a B2-Sequence.

Case #6: It is a B2-Sequence.

Case #7: It is not a B2-Sequence.

Case #8: It is not a B2-Sequence.

Case #9: It is not a B2-Sequence.', '6
3 7 21 54 -1 154

4
1 13 26 45

4
1 9 0 30

3
1 2 2

3
1 2 3

2
9999 10000

100
10 28 74 116 135 226 269 362 410 489 535 615 647 699 759 803 888 903 945 1006 1075 1125 1185 1255 1334 1410 1487 1531 1582 1670 1763 1849 1886 1947 1962 2000 2049 2117 2210 2291 2337 2435 2443 2514 2514 2606 2702 2767 2859 2907 2911 3003 3084 3166 3264 3303 3317 3347 3417 3485 3490 3502 3525 3592 3614 3636 3701 3747 3831 3871 3916 3992 4071 4113 4163 4227 4290 4295 4308 4353 4421 4460 4516 4604 4638 4659 4757 4762 4793 4866 4944 5014 5109 5202 5278 5294 5301 5362 5374 5413 

100
79 138 184 268 285 334 402 458 469 510 550 555 652 729 772 868 875 904 923 982 1001 1071 1162 1167 1229 1263 1267 1353 1380 1471 1548 1621 1698 1704 1803 1896 1979 2041 2057 2066 2164 2201 2269 2280 2295 2344 2393 2477 2479 2578 2617 2619 2665 2713 2744 2794 2832 2873 2911 2981 3016 3077 3105 3138 3169 3182 3195 3265 3327 3330 3388 3411 3461 3550 3618 3618 3678 3718 3801 3884 3892 3916 3993 4029 4091 4114 4155 4246 4261 4283 4285 4342 4432 4447 4514 4607 4683 4710 4779 4811 

99
25 121 121 211 292 379 453 495 592 596 665 686 747 797 850 936 978 984 1065 1122 1218 1245 1336 1341 1521 1533 1602 1658 1728 1750 1826 1829 1854 1930 1949 2045 2136 2222 2238 2326 2344 2374 2402 2494 2537 2563 2626 2626 2725 2776 2807 2876 2902 2955 2977 3008 3101 3161 3166 3189 3273 3304 3394 3442 3471 3538 3558 3638 3672 3706 3772 3780 3869 3884 3896 3975 4006 4035 4043 4068 4116 4164 4164 4211 4292 4340 4399 4449 4514 4531 4590 4598 4694 4763 4829 4849 4853 4893 4941', 'Case #1: It is not a B2-Sequence.

Case #2: It is a B2-Sequence.

Case #3: It is not a B2-Sequence.

Case #4: It is not a B2-Sequence.

Case #5: It is not a B2-Sequence.

Case #6: It is a B2-Sequence.

Case #7: It is not a B2-Sequence.

Case #8: It is not a B2-Sequence.

Case #9: It is not a B2-Sequence.');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (43, 11150, 'Cola', '11150 - Cola', 'https://onlinejudge.org/external/111/p11150.pdf', 1, '//uva11150
#include <iostream>
using namespace std;
 
int main() {
    int N;
    while (cin >> N){
        int ans = N;
        while (N >= 3){
            ans += N / 3;
            N = N / 3 + N % 3;
        }
        ans += (N == 2);
        cout << ans << \"\\n\";
    }
    return 0;
}', '8
9', '12
13', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (44, 11321, 'Sort! Sort!! and Sort!!!', '11321 - Sort! Sort!! and Sort!!!', 'https://onlinejudge.org/external/113/p11321.pdf', 1, '//uva11321
#include <iostream>
#include <algorithm>
#include <stdio.h>
using namespace std;

struct Num {
	int  n,r;
	bool odd;
};

bool comp(const Num& a, const Num& b) {
	bool flag = false;
	if(a.r < b.r) flag = true;
	else if(a.r == b.r) {
		if (a.odd && !b.odd) flag = true;
		else if (!a.odd && b.odd) flag = false;
		else if (a.odd && b.odd) flag = (a.n > b.n);
		else flag = (a.n < b.n);
	}
	return flag;
}

int main() {
	int n,m,t;
	Num a[10000];
	while (cin >> n >> m && !(n == 0 && m == 0)) {
		cout << n << \" \" << m << endl;
		for (int i = 0; i < n; i++) {
			cin >> t;
			a[i].n = t;
			a[i].r = t%m;
			if(t%2 != 0) a[i].odd = true;
			else a[i].odd = false;
		}
		sort(a, a + n,comp);
		for (int i = 0; i < n; i++)
			cout << a[i].n << endl;
	}
	cout << \"0 0\" << endl;
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '測資過長', '測資過長', '測資過長', '測資過長');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (45, 11332, 'Problem J: Summing Digits', '11332 - Problem J: Summing Digits', 'https://onlinejudge.org/external/113/p11332.pdf', 1, '//uva11332
#include <iostream>
#include <vector>

using namespace std;

int main() {
  int a = 0;

  while (cin >> a && a) {
    vector<int> v;

    while (a / 10 != 0) {
      v.push_back(a % 10);
      a /= 10;

      if (a / 10 == 0) {
        for (int i = 0; i < v.size(); i++) {
          a += v[i];
        }
        v.clear();
      }
    }
    cout << a << endl;
  }
  return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '2
11
47
1234567892
1
21
321
5566
99999
789876
1000000
20000002
120340560
1999999999
0', '2
2
2
2
1
3
6
4
9
9
1
4
3
1', '2
11
47
1234567892
8
13
183
4477
98765
999999
8000008
60000000
980760540
1999999998
0', '2
2
2
2
8
4
3
4
8
9
7
6
3
9');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (46, 11349, 'Symmetric Matrix', '11349 - Symmetric Matrix', 'https://onlinejudge.org/external/113/p11349.pdf', 1, '//uva11349
#include <iostream>
#include <vector>
using namespace std;

int main() {
	int t, n, half, symmetric;
	vector< vector<long long> > a( 101, vector<long long>(101) );
	scanf(\"%d\", &t);

	for (int k = 1; k <= t; ++k) {
		symmetric = 1;
		scanf(\"\\nN = %d\", &n);
		for (int i = 0; i < n; ++i) {
			for (int j = 0; j < n; ++j) {
				scanf(\"%lld\", &a[i][j]);
				if (a[i][j] < 0)
					symmetric = 0;
			}
		}

		half = n / 2 + 1;
		for (int i = 0; i < half; ++i) {
			if (symmetric == 0)
				break;

			for (int j = 0; j < n; ++j) {
				if (a[i][j] != a[n - i - 1][n - j - 1]) {
					symmetric = 0;
					break;
				}
			}
		}

		if (symmetric == 1)
			printf(\"Test #%d: Symmetric.\\n\", k);
		else
			printf(\"Test #%d: Non-symmetric.\\n\", k);
	}

	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '31
N = 3
5 1 3
2 0 2
3 1 5
N = 3
5 1 3
2 0 2
0 1 5
N = 3
-5 1 3
2 0 2
3 1 -5
N = 3
1 3 1
2 4 2
1 3 1
N = 3
59 69 49
96 96 96
94 69 95
N = 2
2147483647 -1
-1 2147483647
N = 2
4 5
5 4
N = 1
-42
N = 1
2147483648
N = 2
2147483647 2147483649
2147483649 2147483647
N = 2
4294967296 87
87 4294967296
N = 4
1 2 3 4
2 4 6 8
8 6 4 2
4 3 2 1
N = 4
4 4 4 4
4 -3 -3 4
4 -3 -3 4
4 4 4 4
N = 4
3 7 6 3
3 9 1 3
3 1 9 3
3 6 7 3
N = 5
-1 -2 -3 -4 -5
-6 -7 -8 -9 -10
1 1 1 1 1
-10 -9 -8 -7 -6
-5 -4 -3 -2 -1
N = 5
5 1 3 2 99
2 5 2 1 3
16 77 66 78 16
3 1 2 5 2
99 2 3 1 5
N = 5
2 4 8 3 4
6 7 6 7 2
9 3 7 8 7
2 7 9 7 0
0 3 6 4 6
N = 5
6 0 8 3 7
7 7 9 2 4
3 6 2 6 3
4 2 9 7 7
7 3 8 0 6
N = 5
9 3 4 6 5
1 6 6 6 1
5 7 0 8 3
5 6 4 3 9
3 8 0 7 5
N = 5
-2 -7 -4 -7 0
-1 -1 -5 -3 -3
-1 -5 0 -5 -1
-3 -3 -5 -1 -1
0 -7 -4 -7 -2
N = 7
4 77 9 0 9 77 4
5 8 3 6 8 4 0
6 2 2 2 9 7 3
1 7 4 6 4 7 1
3 7 9 2 2 2 6
0 4 8 6 3 8 5
4 77 9 0 9 77 4
N = 9
7 2 6 4 6 9 6 0 8
7 2 8 6 3 1 1 6 3
8 7 0 0 8 8 9 6 7
9 118 0 4 3 4 5 2 0
2 7 6 7 3 7 6 7 2
0 2 5 4 3 4 0 8 9
7 6 9 8 8 0 0 7 8
3 10 1 1 3 6 8 0 7
8 0 6 9 6 4 6 2 7
N = 8
27 11 10 12 33 23 31 34
11 29 13 36 19 12 34 13
35 34 11 26 24 33 32 12
13 34 11 12 17 15 11 24
24 11 15 17 12 11 34 13
12 32 33 24 26 11 34 35
13 34 12 19 36 13 29 11
34 31 23 33 12 10 11 27
N = 11
-1 1 1 -1 1 -1 1 -1 1 1 -1
-1 1 1 -1 1 -1 1 -1 1 1 -1
-1 1 1 -1 1 -1 1 -1 1 1 -1
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
-1 1 1 -1 1 -1 1 -1 1 1 -1
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
-1 1 1 -1 1 -1 1 -1 1 1 -1
-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
-1 1 1 -1 1 -1 1 -1 1 1 -1
-1 1 1 -1 1 -1 1 -1 1 1 -1
-1 1 1 -1 1 -1 1 -1 1 1 -1
N = 8
34 24 28 38 16 16 35 23
11 22 36 30 31 28 16 35
34 24 28 38 16 16 35 23
31 28 32 38 23 16 16 27
23 35 16 16 38 28 24 34
35 35 19 20 17 26 18 24
24 18 26 17 20 19 35 35
27 16 16 23 38 32 28 31
N = 10
6 19 28 3 28 12 27 25 23 20
24 10 6 27 13 13 15 28 1 17
19 21 25 27 17 2 16 21 9 25
1 24 0 9 1 29 21 0 21 17
2 8 5 14 18 5 12 10 28 6
6 28 10 12 5 18 14 5 8 2
17 21 0 21 29 1 9 0 24 1
25 9 21 16 2 17 27 25 21 19
17 1 28 15 13 13 27 6 10 24
20 23 25 27 12 28 3 28 19 6
N = 12
42 79 11 33 84 56 41 69 38 75 11 80
41 39 75 25 54 22 71 44 15 66 26 68
43 66 46 59 17 26 17 79 39 66 22 38
211 354 414 583 665 762 821 958 1061 1164 1281 134
51 36 89 25 45 55 18 61 77 51 63 24
36 45 41 77 82 64 45 81 47 89 22 28
28 22 89 47 81 45 64 82 77 41 45 36
24 63 51 77 61 18 55 45 25 89 36 51
134 1281 1164 1061 958 821 762 665 583 414 354 211
38 22 66 39 79 17 26 17 59 46 66 43
68 26 66 15 44 71 22 54 25 75 39 41
80 11 75 38 69 41 56 84 33 11 79 42
N = 15
89 32 57 41 74 61 76 71 12 75 83 78 66 58 70
31 58 69 46 14 45 46 74 11 76 25 61 14 41 61
59 24 69 87 68 24 89 49 17 11 56 67 78 87 67
72 39 89 45 53 23 62 82 21 45 63 66 40 64 32
67 45 70 58 38 13 32 86 41 74 89 45 78 40 31
79 43 10 34 16 50 15 12 89 82 46 80 77 15 64
70 11 62 29 22 68 85 58 20 61 33 49 45 86 56
80 80 76 80 54 14 44 32 44 14 54 80 76 80 80
56 86 45 49 33 61 20 58 85 68 22 29 62 11 70
64 15 77 80 46 82 89 12 15 50 16 34 10 43 79
31 40 78 45 89 74 41 86 32 13 38 58 70 45 67
32 64 40 66 63 45 21 82 62 23 53 45 89 39 72
67 87 78 67 56 11 17 49 89 24 68 87 69 24 59
61 41 14 61 25 76 11 74 46 45 14 46 69 58 31
70 58 66 78 83 75 12 71 76 61 74 41 57 32 89
N = 20
9 -2 5 -17 7 9 12 5 4 14 15 15 17 12 -9 17 9 17 15 4
16 3 15 2 10 12 16 11 12 6 3 9 7 8 11 4 18 -15 1 10
14 0 2 7 4 16 16 3 19 9 7 17 6 12 9 7 11 19 12 13
13 17 11 7 14 3 3 15 1 5 10 18 15 -13 18 9 16 19 -11 6
1 6 9 4 -15 18 4 8 -19 13 17 -5 15 14 15 15 6 0 9 7
8 8 5 17 15 2 17 9 7 9 -13 7 1 4 14 15 1 19 17 4
9 18 -18 16 19 17 14 19 7 5 6 15 14 14 10 8 6 14 13 17
15 4 11 18 5 15 0 2 14 12 3 12 10 18 11 10 5 19 12 18
9 4 9 4 0 13 7 7 0 12 6 6 9 13 8 14 6 11 2 -7
11 10 14 7 14 14 16 6 5 10 -5 6 3 16 10 13 6 3 10 5
5 10 3 -6 13 10 16 3 6 5 10 5 6 16 -14 14 7 14 10 11
7 2 11 6 14 8 13 -9 6 6 12 0 7 7 13 0 4 9 4 9
18 12 19 5 10 11 18 10 12 3 12 14 2 0 15 5 18 11 4 15
17 13 14 6 8 10 14 14 15 6 5 7 -19 14 17 19 16 18 18 9
4 17 -19 1 15 14 4 1 7 13 9 7 9 17 2 15 17 5 8 8
7 9 0 6 15 15 14 15 5 17 13 19 8 4 18 -15 4 9 6 1
6 11 19 16 9 18 13 15 18 -10 5 1 15 3 -3 14 7 11 17 13
13 -12 19 -11 7 9 12 6 17 7 9 19 3 16 16 4 7 2 0 14
10 1 15 18 4 11 8 7 9 3 6 12 11 16 12 10 2 15 3 16
4 15 -17 9 17 9 12 17 15 15 14 4 -5 12 9 7 17 5 -2 9
N = 20
0 4 3 1 2 4 7 2 6 3 8 6 2 1 3 9 8 7 1 0
6 0 4 7 6 3 5 1 5 0 7 7 7 5 1 4 2 1 5 3
1 6 2 3 6 6 8 3 5 9 5 1 3 8 3 9 5 5 4 7
4 6 2 6 6 9 3 9 3 7 3 8 6 9 6 3 1 4 7 5
5 5 5 5 1 4 3 2 0 8 7 6 5 3 0 8 0 8 6 5
2 8 8 3 2 1 2 4 3 8 0 6 2 8 7 8 4 7 5 2
6 1 0 8 3 3 2 5 6 7 6 4 6 7 1 7 2 2 8 0
5 9 0 2 3 1 6 1 9 0 3 4 6 1 9 4 0 1 9 6
9 4 1 7 4 8 2 4 6 5 7 9 6 6 1 2 9 7 1 5
1 2 7 0 1 4 9 9 7 7 8 7 3 1 6 1 8 0 1 0
0 1 0 8 1 6 1 3 7 8 7 7 9 9 4 1 0 7 2 1
5 1 7 9 2 1 6 6 9 7 5 6 4 2 8 4 7 1 4 9
6 9 1 0 4 9 1 6 4 3 0 9 1 6 1 3 2 0 9 5
0 8 2 2 7 1 7 6 4 6 7 6 5 2 3 3 8 0 1 6
2 5 7 4 8 7 8 2 6 0 8 3 4 2 1 2 3 8 8 2
5 6 8 0 8 0 3 5 6 7 8 0 2 3 4 1 5 5 5 5
5 7 4 1 3 6 9 6 8 3 7 3 9 3 9 6 6 2 6 4
7 4 5 5 9 3 8 3 1 5 9 5 3 8 6 6 3 2 6 1
3 5 1 2 4 1 5 7 7 7 0 5 1 5 3 6 7 4 0 6
0 1 7 8 9 3 1 2 6 8 3 6 2 7 4 2 1 3 4 0
N = 50
10 13 28 0 15 13 8 9 0 7 27 3 24 11 27 16 26 23 3 22 15 2 9 1 22 3 28 7 29 28 17 9 13 4 10 23 9 9 18 0 2 14 4 27 18 15 16 4 29 23
7 19 6 19 16 2 20 22 14 16 5 29 28 3 5 11 0 10 15 23 14 11 21 24 29 29 3 13 24 28 23 24 11 24 6 12 23 16 8 5 27 22 3 21 19 10 18 4 3 22
4 23 7 12 1 12 19 2 9 24 3 2 25 1 17 25 12 3 15 15 23 10 26 29 7 1 24 8 27 23 3 27 18 6 6 15 18 5 25 10 9 26 13 5 23 21 3 24 21 11
0 11 2 20 3 20 17 4 6 29 3 19 7 0 5 0 19 9 24 8 5 5 16 27 7 28 27 29 19 21 27 9 24 18 26 11 16 6 27 27 11 9 16 16 10 27 14 24 26 9
29 4 19 25 16 24 26 7 24 18 29 9 6 8 23 23 7 2 23 2 1 9 3 22 6 17 0 21 20 17 28 3 9 15 19 4 14 4 12 11 0 15 24 12 11 19 14 12 25 22
8 7 1 8 7 25 29 24 11 24 11 5 3 10 3 0 22 23 9 26 29 2 5 29 3 19 7 2 19 6 8 2 28 5 15 13 28 4 28 13 2 21 22 28 13 6 14 25 22 25
19 23 29 2 11 6 28 3 16 26 20 6 17 23 4 21 1 24 12 11 13 29 19 17 8 28 15 29 29 24 29 22 21 11 26 13 15 21 15 28 3 8 18 12 8 25 10 13 6 3
3 6 8 11 0 21 25 21 15 15 10 0 2 7 8 4 19 3 16 7 6 20 25 3 13 8 19 13 6 2 23 21 23 15 7 7 0 10 28 12 1 14 25 8 14 2 22 13 9 0
2 23 10 18 22 9 0 12 20 18 2 26 1 29 0 18 27 5 12 16 18 2 26 10 15 16 19 27 25 8 6 6 2 26 12 18 29 2 13 28 26 1 3 14 28 23 17 15 8 26
21 12 15 5 0 21 7 8 17 26 22 20 6 1 17 1 16 11 29 2 18 27 5 14 8 14 0 12 27 13 14 22 27 10 14 20 6 14 8 23 9 9 18 14 20 0 13 17 8 21
10 5 14 7 21 7 3 13 4 16 12 8 23 12 16 25 2 17 18 15 6 1 21 6 8 29 18 7 7 7 10 21 14 12 7 12 28 8 10 9 1 24 16 4 10 17 2 7 1 28
16 11 7 9 17 23 2 14 4 19 7 26 25 15 28 27 20 22 13 3 11 23 10 26 8 23 10 4 23 21 29 28 27 21 7 4 27 21 18 19 11 11 0 16 11 11 3 5 19 3
11 9 0 29 19 9 6 7 26 2 28 12 9 6 21 4 6 1 24 16 14 13 9 9 29 22 10 17 6 18 12 13 15 12 12 0 24 10 2 4 16 9 7 4 24 6 12 3 2 17
17 12 24 17 1 9 26 3 11 2 23 16 4 8 5 19 0 10 7 25 9 28 20 8 22 6 11 7 7 14 25 7 6 13 9 24 15 28 28 28 15 28 25 24 23 28 19 11 10 7
18 15 1 11 11 13 13 10 6 9 17 10 7 12 17 5 0 16 9 3 24 10 22 16 25 9 23 3 6 11 26 17 1 6 6 1 4 23 21 15 5 10 8 26 10 26 28 12 14 5
6 10 18 5 18 5 29 27 25 8 17 22 13 14 8 21 15 19 29 16 28 15 0 29 14 4 9 20 8 24 26 9 20 28 22 21 28 7 14 20 25 5 6 15 27 7 23 4 15 1
5 5 16 22 11 21 25 13 11 26 21 10 4 8 15 1 25 13 20 14 4 25 1 29 2 9 4 18 22 22 1 19 19 5 6 26 16 21 19 13 29 12 15 13 2 9 8 17 20 19
20 20 14 14 10 11 24 5 9 14 12 28 18 21 18 10 21 21 21 6 9 18 29 15 11 25 4 29 10 10 18 14 28 21 29 0 4 26 24 0 20 9 4 29 5 15 20 25 25 9
12 20 14 22 15 26 12 19 17 24 12 12 26 9 19 23 9 10 26 15 29 12 12 12 11 24 27 7 9 14 20 18 5 1 28 21 22 9 20 3 2 1 26 29 22 9 4 26 28 5
2 22 26 6 13 23 27 28 29 15 18 16 9 3 15 18 3 14 21 12 17 23 16 22 28 8 28 25 0 3 23 26 6 0 9 9 21 12 4 2 20 6 28 17 28 24 3 17 19 29
7 10 14 9 25 23 14 9 21 10 16 2 0 20 3 10 11 2 21 21 11 8 8 16 10 2 7 19 12 29 21 17 10 7 27 4 19 12 28 7 6 0 21 9 11 14 19 4 17 4
15 25 5 29 19 1 18 18 14 14 16 23 18 13 24 14 16 16 15 14 15 1 3 28 6 8 10 16 5 9 19 13 19 0 23 22 3 17 17 6 2 19 22 0 18 15 19 14 29 10
16 7 9 5 9 18 28 27 4 7 13 11 17 24 22 1 14 16 25 24 27 21 6 12 14 13 1 25 15 10 21 14 22 12 22 23 5 21 0 2 3 4 25 26 2 5 21 27 28 14
16 14 20 13 20 15 22 12 23 7 4 9 27 13 14 7 24 5 23 21 20 25 22 10 20 15 25 15 0 12 27 29 6 5 24 13 12 2 16 18 5 29 14 14 13 23 19 11 14 13
14 15 2 6 2 6 22 12 23 28 3 22 16 6 3 15 14 9 8 7 13 19 15 22 25 10 9 2 1 27 10 10 23 26 23 20 24 25 19 4 6 5 24 25 16 27 17 6 2 4
4 2 6 17 27 16 25 24 5 6 4 19 25 24 20 23 26 23 10 10 27 1 2 9 10 25 22 15 19 13 7 8 9 14 15 3 6 16 22 3 28 23 12 22 6 2 6 2 15 14
13 14 11 19 23 13 14 14 29 5 18 16 2 12 13 24 5 6 29 27 12 0 15 25 15 20 10 22 25 20 21 23 5 24 7 14 13 27 9 4 7 23 12 22 15 20 13 20 14 16
14 28 27 21 5 2 26 25 4 3 2 0 21 5 23 22 12 22 14 21 10 15 25 1 13 14 12 6 21 27 24 25 16 14 1 22 24 17 11 13 7 4 27 28 18 9 5 9 7 16
10 29 14 19 15 18 0 22 19 2 6 17 17 3 22 23 0 19 13 19 9 5 16 10 8 6 28 3 1 15 14 15 16 16 14 24 13 18 23 16 14 14 18 18 1 19 29 5 25 15
4 17 4 19 14 11 9 21 0 6 7 28 12 19 4 27 7 10 17 21 29 12 19 7 2 10 16 8 8 11 21 21 2 11 10 3 20 0 2 16 10 21 9 14 23 25 9 14 10 7
29 19 17 3 24 28 17 28 6 20 2 4 12 21 9 9 0 6 26 23 3 0 25 28 8 28 22 16 23 17 12 21 14 3 18 15 3 9 16 18 15 29 28 27 23 13 6 26 22 2
5 28 26 4 9 22 29 26 1 2 3 20 9 22 21 28 1 5 18 20 14 9 7 27 24 11 12 12 12 29 15 26 10 9 23 19 9 26 12 12 24 17 19 12 26 15 22 14 20 12
9 25 25 20 15 5 29 4 9 20 0 24 26 4 0 29 21 28 14 18 10 10 29 4 25 11 15 29 18 9 6 21 21 21 10 18 21 18 28 12 14 9 5 24 11 10 14 14 20 20
19 20 17 8 9 2 13 15 12 29 13 19 21 16 26 6 5 19 19 1 22 22 18 4 9 2 29 1 25 4 14 20 13 25 1 15 8 4 10 21 26 11 13 25 21 11 22 16 5 5
1 15 4 23 7 27 15 6 5 25 20 14 7 28 21 22 28 20 9 26 24 8 20 9 4 14 29 0 15 28 16 29 19 15 21 8 14 13 22 17 8 25 27 29 5 18 5 18 10 6
5 14 12 28 26 10 26 8 10 5 15 21 23 4 1 6 6 1 17 26 11 6 3 23 9 25 16 22 10 24 3 9 16 0 5 17 12 7 10 17 9 6 10 13 13 11 11 1 15 18
7 10 11 19 28 23 24 25 28 15 28 28 28 15 24 9 13 6 7 25 14 7 7 11 6 22 8 20 28 9 25 7 10 0 19 5 8 4 16 23 2 11 3 26 9 1 17 24 12 17
17 2 3 12 6 24 4 7 9 16 4 2 10 24 0 12 12 15 13 12 18 6 17 10 22 29 9 9 13 14 16 24 1 6 4 21 6 9 12 28 2 26 7 6 9 19 29 0 9 11
3 19 5 3 11 11 16 0 11 11 19 18 21 27 4 7 21 27 28 29 21 23 4 10 23 8 26 10 23 11 3 13 22 20 27 28 15 25 26 7 19 4 14 2 23 17 9 7 11 16
28 1 7 2 17 10 4 16 24 1 9 10 8 28 12 7 12 14 21 10 7 7 7 18 29 8 6 21 1 6 15 18 17 2 25 16 12 23 8 12 16 4 13 3 7 21 7 14 5 10
21 8 17 13 0 20 14 18 9 9 23 8 14 6 20 14 10 27 22 14 13 27 12 0 14 8 14 5 27 18 2 29 11 16 1 17 1 6 20 22 26 17 8 7 21 0 5 15 12 21
26 8 15 17 23 28 14 3 1 26 28 13 2 29 18 12 26 2 6 6 8 25 27 19 16 15 10 26 2 18 16 12 5 27 18 0 29 1 26 2 18 20 12 0 9 22 18 10 23 2
0 9 13 22 2 14 8 25 14 1 12 28 10 0 7 7 15 23 21 23 2 6 13 19 8 13 3 25 20 6 7 16 3 19 4 8 7 2 0 10 15 15 21 25 21 0 11 8 6 3
3 6 13 10 25 8 12 18 8 3 28 15 21 15 13 26 11 21 22 29 24 29 29 15 28 8 17 19 29 13 11 12 24 1 21 4 23 17 6 20 26 16 3 28 6 11 2 29 23 19
25 22 25 14 6 13 28 22 21 2 13 28 4 28 13 15 5 28 2 8 6 19 2 7 19 3 29 5 2 29 26 9 23 22 0 3 10 3 5 11 24 11 24 29 25 7 8 1 7 8
22 25 12 14 19 11 12 24 15 0 11 12 4 14 4 19 15 9 3 28 17 20 21 0 17 6 22 3 9 1 2 23 2 7 23 23 8 6 9 29 18 24 7 26 24 16 25 19 4 29
9 26 24 14 27 10 16 16 9 11 27 27 6 16 11 26 18 24 9 27 21 19 29 27 28 7 27 16 5 5 8 24 9 19 0 5 0 7 19 3 29 6 4 17 20 3 20 2 11 0
11 21 24 3 21 23 5 13 26 9 10 25 5 18 15 6 6 18 27 3 23 27 8 24 1 7 29 26 10 23 15 15 3 12 25 17 1 25 2 3 24 9 2 19 12 1 12 7 23 4
22 3 4 18 10 19 21 3 22 27 5 8 16 23 12 6 24 11 24 23 28 24 13 3 29 29 24 21 11 14 23 15 10 0 11 5 3 28 29 5 16 14 22 20 2 16 19 6 19 7
23 29 4 16 15 18 27 4 14 2 0 18 9 9 23 10 4 13 9 17 28 29 7 28 3 22 1 9 2 15 22 3 23 26 16 27 11 24 3 27 7 0 9 8 13 15 0 28 13 10', 'Test #1: Symmetric.
Test #2: Non-symmetric.
Test #3: Non-symmetric.
Test #4: Symmetric.
Test #5: Non-symmetric.
Test #6: Non-symmetric.
Test #7: Symmetric.
Test #8: Non-symmetric.
Test #9: Symmetric.
Test #10: Symmetric.
Test #11: Symmetric.
Test #12: Symmetric.
Test #13: Non-symmetric.
Test #14: Symmetric.
Test #15: Non-symmetric.
Test #16: Non-symmetric.
Test #17: Non-symmetric.
Test #18: Symmetric.
Test #19: Non-symmetric.
Test #20: Non-symmetric.
Test #21: Symmetric.
Test #22: Non-symmetric.
Test #23: Symmetric.
Test #24: Non-symmetric.
Test #25: Non-symmetric.
Test #26: Symmetric.
Test #27: Symmetric.
Test #28: Symmetric.
Test #29: Non-symmetric.
Test #30: Symmetric.
Test #31: Symmetric.', '31
N = 1
-1
N = 1
56
N = 1
0
N = 1
2147483648
N = 2
49 97
97 49
N = 2
-1 1
1 -1
N = 2
2147483647 2147483649
2147483649 2147483647
N = 3
5 4 3
2 -5 2
3 4 5
N = 3
23 86 97
14 73 41
35 52 67
N = 3
7 -9 -5
0 6 5
-5 -9 7
N = 3
5 1 3
2 5 2
1 2 99
N = 4
4294967296 87 1 3
2 47 2 73
73 2 47 2
3 1 87 4294967296
N = 4
3 2 0 3
1 1 2 9
9 2 1 1
3 0 2 3
N = 5
7 8 1 8 1
3 6 7 2 5
4 3 1 3 4
5 2 7 6 3
1 8 1 8 7
N = 5
0 0 3 2 -9
2 5 2 1 3
777 77 66 78 777
3 1 2 5 2
99 2 3 1 5
N = 5
4 1 3 2 99
2 5 2 1 2
987 77 66 77 987
2 1 2 5 2
99 2 3 1 4
N = 5
-4 1 -3 2 -99
-3 5 -2 5 -3
-744 34 -1 34 -744
-3 5 -2 5 -3
-99 2 -3 1 -4
N = 5
6 9 0 6 0
3 4 4 5 3
5 4 6 4 5
3 5 4 4 3
0 6 0 9 6
N = 5
4294967296 67296 294967296 94967296 4294967296
67296 294967296 29409607296 7096724 88294967296
967296 2941967296 4294967293 4294967296 4294967296
429496 1429296 4294967296 4294967 4294967296
7296 4294967296 4294967296 4294967296 67296
N = 6
2 0 5 4 9 1
3 3 5 8 3 6
8 7 0 5 8 0
0 8 5 0 7 8
6 3 8 5 3 3
1 9 4 5 0 2
N = 7
1 9 2 3 5 4 2
2 9 9 9 3 8 8
6 7 0 5 1 6 8
4 8 0 0 7 6 3
8 3 9 9 9 5 1
8 9 6 2 9 9 2
8 6 3 4 1 3 8
N = 8
6 4 0 9 6 0 2 2
4 7 1 4 8 8 2 6
7 3 3 5 0 3 4 9
8 5 8 9 8 2 3 1
1 3 2 8 9 8 5 8
9 4 3 0 5 3 3 7
6 2 8 8 4 1 7 4
2 2 0 6 9 0 4 6
N = 10
1 2 3 4 5 6 7 8 9 10
11 12 13 14 15 16 17 18 19 20
21 22 23 24 25 26 27 28 29 30
31 32 33 34 35 36 37 38 39 40
41 42 43 44 45 46 47 48 49 50
51 52 53 54 55 56 57 58 59 60
61 62 63 64 65 66 67 68 69 70
71 72 73 74 75 76 77 78 79 80
81 82 83 84 85 86 87 88 89 90
91 92 93 94 95 96 97 98 99 100
N = 11
0 0 6 0 2 1 1 0 0 0 9
0 0 0 0 0 2 5 4 0 0 3
0 0 8 0 6 0 4 6 0 2 0
0 9 0 0 8 0 4 2 0 2 7
0 0 0 0 6 8 0 0 0 0 0
3 8 1 0 7 0 0 7 0 0 3
0 8 0 1 7 8 6 8 0 0 0
7 2 0 0 0 0 0 9 9 9 2
3 2 3 0 4 8 0 6 8 8 0
3 3 0 0 5 0 0 0 4 3 8
9 2 0 6 1 0 0 0 6 9 0
N = 12
3 8 0 0 0 0 1 0 7 3 0 0
8 0 0 0 0 0 1 9 2 0 9 5
0 3 0 9 2 4 0 1 7 0 2 0
8 6 0 0 6 0 0 0 5 0 1 3
0 8 4 0 2 0 5 0 6 0 0 0
0 8 0 0 4 0 0 0 0 7 0 1
2 3 8 0 0 8 4 0 0 7 9 0
7 4 0 0 0 0 0 0 4 8 0 0
4 0 2 8 9 0 4 0 0 0 0 0
0 0 8 6 0 0 0 1 0 2 0 4
0 5 0 3 8 0 0 0 0 8 0 9
0 0 2 0 3 0 0 0 9 7 0 1
N = 13
5 2 2 4 9 2 0 4 9 8 4 3 6
7 9 9 8 0 1 3 0 8 4 6 2 2
0 9 5 9 3 2 2 9 0 0 7 2 0
2 2 7 8 8 7 2 3 6 8 5 7 4
9 0 2 4 9 3 6 2 9 0 8 6 1
1 7 2 3 1 1 7 2 5 9 2 0 3
7 4 7 1 9 6 3 6 9 1 7 4 7
3 0 2 9 5 2 7 1 1 3 2 7 1
1 6 8 0 9 2 6 3 9 4 2 0 9
4 7 5 8 6 3 2 7 8 8 7 2 2
0 2 7 0 0 9 2 2 3 9 5 9 0
2 2 6 4 8 0 3 1 0 8 9 9 7
6 3 4 8 9 4 0 2 9 4 2 2 5
N = 16
3 5 3 8 5 3 4 9 2 6 7 6 2 9 9 7
0 1 2 5 6 7 9 5 7 9 1 8 0 0 2 4
3 4 7 2 2 6 2 7 2 7 3 7 2 0 6 0
0 5 1 1 1 9 2 9 0 1 3 5 6 8 1 0
2 6 9 7 2 1 2 8 9 7 9 5 4 8 3 0
9 1 9 5 6 0 3 6 6 3 8 1 7 2 6 0
9 1 7 5 8 7 0 6 2 4 9 3 9 6 6 3
6 9 8 4 1 9 1 8 6 4 4 4 7 8 3 6
6 3 8 7 4 4 4 6 8 1 9 1 4 8 9 6
3 6 6 9 3 9 4 2 6 0 7 8 5 7 1 9
0 6 2 7 1 8 3 6 6 3 0 6 5 9 1 9
0 3 8 4 5 9 7 9 8 2 1 2 7 9 6 2
0 1 8 6 5 3 1 0 9 2 9 1 1 1 5 0
0 6 0 2 7 3 7 2 7 2 6 2 2 7 4 3
4 2 0 0 8 1 9 7 5 9 7 6 5 2 1 0
7 9 9 2 6 7 6 2 9 4 3 5 8 3 5 3
N = 18
0 8 2 0 0 0 3 0 0 6 9 0 7 4 0 8 8 7
3 0 8 7 0 0 0 0 7 1 5 3 0 0 0 0 0 5
4 6 0 0 1 7 4 0 9 0 0 0 6 7 7 0 0 4
7 0 7 1 7 5 0 6 0 0 8 0 0 0 2 0 0 8
3 0 0 6 0 0 0 0 1 8 0 0 0 8 0 0 0 9
4 2 9 2 0 2 0 0 3 0 0 0 9 0 0 0 0 6
0 0 5 0 9 0 5 5 0 0 0 4 0 0 0 0 0 0
0 0 7 0 3 5 0 7 0 0 0 0 9 0 0 6 0 0
0 0 0 0 7 0 0 0 0 0 9 1 0 0 6 0 8 0
7 0 2 6 3 0 1 0 2 6 0 3 0 7 9 1 0 5
0 7 6 2 8 9 1 6 0 0 7 0 5 0 0 0 0 0
0 0 0 0 3 0 0 0 3 0 5 0 9 0 5 0 0 0
6 6 5 0 4 9 0 0 5 0 0 1 2 9 0 0 0 4
9 6 5 7 0 5 7 0 8 1 3 4 0 0 6 7 0 0
0 0 0 0 0 0 0 0 0 1 6 6 0 7 0 0 0 7
0 0 3 0 7 6 0 6 2 0 1 0 7 0 0 2 0 0
5 0 5 1 3 0 3 0 1 7 3 4 3 2 7 0 0 0
0 8 8 0 0 0 0 0 6 0 0 0 0 0 0 2 0 0
N = 22
8 0 2 0 8 8 2 2 8 9 5 2 9 5 9 1 2 6 9 0 6 3
1 1 7 6 5 0 9 7 7 9 2 8 9 0 2 4 2 2 5 0 8 2
0 3 7 0 2 3 2 0 8 3 8 5 2 5 6 5 2 1 8 6 9 5
1 4 6 9 0 8 8 4 3 3 6 5 6 3 7 5 0 5 8 7 7 0
7 6 1 5 5 9 4 9 2 1 1 8 5 1 7 8 9 4 7 7 7 6
1 8 8 4 6 8 8 7 8 8 5 1 3 8 3 0 3 8 9 3 3 8
2 4 2 2 3 6 8 2 6 9 9 1 0 2 3 1 5 4 4 3 8 0
8 2 0 5 6 3 3 9 6 1 6 0 3 4 7 0 4 0 4 2 4 7
0 9 2 2 4 0 1 2 3 8 6 2 7 1 9 9 3 5 2 7 7 1
4 3 1 3 2 0 9 8 6 8 6 0 4 7 7 1 5 1 4 4 0 1
6 3 6 2 7 6 5 8 1 8 2 3 2 3 4 0 8 6 9 8 2 1
1 2 8 9 6 8 0 4 3 2 3 2 8 1 8 5 6 7 2 6 3 6
1 0 4 4 1 5 1 7 7 4 0 6 8 6 8 9 0 2 3 1 3 4
1 7 7 2 5 3 9 9 1 7 2 6 8 3 2 1 0 4 2 2 9 0
7 4 2 4 0 4 0 7 4 3 0 6 1 6 9 3 3 6 5 0 2 8
0 8 3 4 4 5 1 3 2 0 1 9 9 6 2 8 6 3 2 2 4 2
8 3 3 9 8 3 0 3 8 3 1 5 8 8 7 8 8 6 4 8 8 1
6 7 7 7 4 9 8 7 1 5 8 1 1 2 9 4 9 5 5 1 6 7
0 7 7 8 5 0 5 7 3 6 5 6 3 3 4 8 8 0 9 6 4 1
5 9 6 8 1 2 5 6 5 2 5 8 3 8 0 2 3 2 0 7 3 0
2 8 0 5 2 2 4 2 0 9 8 2 9 7 7 9 0 5 6 7 1 1
3 6 0 9 6 2 1 9 5 9 2 5 9 8 2 2 8 8 0 2 0 8
N = 23
35 1 11 4 28 27 19 27 15 11 35 14 4 26 1 33 18 10 12 1 3 15 1381922
15 14 26 24 26 39 25 22 15 11 24 39 29 26 15 18 23 17 14 15 36 3 22
163 14 16 28 367 418 14 32 25 23 413 13 20 23 6 3 3 3 39 25 27 39 14
3666 20 30 13 30 26 11 35 39 25 16 28 11 10 31 18 34 3 29 21 34 19 13
329 35 19 28 33 27 38 12 5 36 36 13 12 20 33 14 10 31 22 26 20 19 39
128 33 26 29 27 16 19 29 17 13 29 12 16 25 32 12 36 36 13 34 35 25 6
33 33 15 28 32 6 22 12 38 22 33 38 21 22 2 1 31 20 35 26661 26 1 37
2166 28 22 34 29 32 23 35 14 34 13 22 18 0 14 39 11 10 24 23 28 32 32
17 17 29 27 1 39 37 217 20 25 31 19 34 20 35 34 27 16 10 32 30 21 2
30 22 14 16 33 35 15 1 14 39 10 28 10 29 35 26 15 21 26 29 31 16 15
147 12 36 24 22 32 3 38 28 26 17 10 13 38 23 21 36 33 24 27 29 26 15
260 26 14 32 7 21 135 10 12 0 34 21 34 10 12 10 15 21 37 32 14 26 20
15 26 29 27 24 33 36 21 23 38 1 10 17 26 28 38 39 32 22 24 36 12 14
15 16 31 29 26 1 15 26 35 29 10 28 0 379 14 11 15 35 33 16 14 22 30
24 21 30 32 1 16 27 34 35 20 34 19 31 25 20 17 37 39 21 27 29 17 17
32 32 28 23 24 10 11 39 14 10 18 22 13 34 14 35 23 32 9 34 22 28 21
357 17 26 21 35 0 31 10 22 22 2551 38 33 22 38 12 2 26 32 8 125 33 33
26 25 35 34 13 36 36 12 32 25 16 12 29 13 17 29 19 16 27 9 26 33 28
9 19 20 26 2 31 10 14 33 20 12 13 36 36 30 12 38 27 33 28 19 35 30459
13 19 34 21 29 537 354 18 31 10 11 28 16 25 39 35 11 26 30 3 30 20 36
4 39 27 25 39 30 37 39 26 23 0 1 13 23 5 3456242 14 18 37 28 16 14 16
36522 38 36 15 1 17 23 18 15 26 29 39 24 11 15 22 25 39 26 24 2 14 15
2 15 39 31 12 0 18 313 6 26 324 4 35 11 50 2337 19 27 28 14 161 12 35
N = 55
1 5 2 3 2 1 5 4 0 6 0 9 5 6 3 1 5 1 3 5 3 0 3 2 0 5 2 4 5 7 2 5 3 7 5 7 1 6 0 0 3 7 4 4 7 1 9 3 8 9 6 4 6 7 8
2 1 0 5 6 5 1 7 6 9 2 4 3 5 1 7 6 2 4 3 3 6 0 7 2 7 7 6 3 4 6 5 8 2 3 2 0 2 2 6 8 7 5 4 9 3 5 2 8 3 4 3 4 0 7
0 6 0 6 1 1 6 2 5 3 7 1 9 5 5 7 1 5 5 5 3 8 5 5 8 5 7 4 2 2 3 1 8 5 7 2 4 0 7 5 9 5 4 3 9 9 6 4 9 7 9 9 9 0 8
8 6 1 6 6 5 0 1 7 1 0 0 4 3 5 1 8 9 2 5 2 9 8 1 8 7 3 1 2 0 1 1 6 0 4 0 7 3 2 6 5 6 3 1 2 8 8 1 4 7 8 4 7 3 8
1 1 0 7 5 7 3 5 2 8 0 4 6 5 2 0 2 1 3 1 3 0 0 7 3 1 7 1 3 3 9 9 7 3 3 6 7 2 8 0 7 1 0 1 7 5 4 6 3 4 4 8 9 3 0
0 8 7 1 1 0 3 0 5 2 0 3 0 6 4 3 4 9 0 1 8 9 7 2 8 1 4 7 3 0 4 2 7 9 5 0 6 1 7 6 6 3 8 9 2 7 0 5 9 1 8 0 6 8 3
4 0 8 4 9 4 6 5 6 9 2 9 9 3 9 2 3 8 0 4 6 2 1 9 8 5 2 4 7 5 5 7 0 2 2 1 0 5 9 5 3 6 3 4 2 2 1 6 7 8 5 4 3 8 8
8 9 7 8 3 8 0 7 2 7 7 9 8 4 7 0 6 7 5 5 9 3 9 2 9 5 0 7 9 8 1 6 8 7 9 5 0 5 9 5 2 1 9 7 0 0 2 4 7 0 2 3 7 5 0
0 0 9 5 1 6 7 1 4 2 5 6 7 9 5 4 2 5 3 0 3 0 7 5 8 8 6 2 0 1 6 7 4 0 1 8 7 3 0 3 1 7 3 1 2 5 2 5 8 6 5 8 2 9 5
8 2 4 6 7 9 4 6 6 4 3 3 1 4 4 6 6 1 6 1 8 8 8 0 6 9 7 9 3 8 9 0 6 9 6 7 5 0 9 4 9 2 5 3 6 7 9 4 2 5 7 1 1 7 0
4 1 0 3 4 1 0 7 1 9 4 2 9 9 1 5 4 2 8 3 2 8 2 6 2 2 8 5 4 5 7 0 3 9 4 9 4 4 9 2 2 1 5 5 2 1 7 2 3 9 7 3 5 8 6
4 0 5 4 1 3 9 2 1 7 2 4 1 9 9 9 5 9 4 6 1 4 8 9 1 5 3 5 6 7 0 0 0 0 4 0 6 9 3 1 7 0 7 4 4 2 2 5 1 1 2 0 9 4 6
4 7 0 6 4 5 4 5 6 2 1 2 1 9 6 2 5 9 3 1 4 4 5 4 9 5 4 4 2 7 8 4 4 9 1 4 5 9 8 7 2 3 4 3 9 1 5 8 3 9 6 8 8 4 2
6 0 2 4 5 6 8 8 0 1 2 8 1 5 5 8 6 5 9 0 4 1 5 2 9 5 8 5 0 6 8 6 8 7 0 4 9 2 9 1 6 7 1 9 7 0 6 8 6 8 4 0 3 8 5
7 9 5 8 8 7 8 3 3 6 6 8 4 1 4 3 5 6 4 1 7 8 3 5 6 1 2 2 5 8 2 0 7 0 8 4 2 1 4 6 0 4 6 0 7 1 2 5 5 6 2 8 6 8 4
0 5 9 9 1 8 1 5 3 4 8 7 5 6 7 6 4 9 0 4 8 5 7 7 4 8 9 3 9 0 6 8 6 7 2 4 6 0 6 4 9 4 0 7 0 9 9 8 6 0 3 4 9 0 9
4 5 1 2 7 6 0 8 6 7 3 7 4 5 4 5 4 1 9 4 0 2 8 5 3 7 0 1 5 6 7 1 7 6 2 7 4 5 3 8 8 5 7 8 1 7 4 4 8 0 8 1 9 9 4
4 8 0 1 6 9 7 4 6 8 8 7 5 9 9 1 4 1 5 3 5 6 9 2 1 4 9 2 2 7 2 8 4 0 9 2 2 3 8 9 2 9 6 6 6 5 3 2 2 2 0 0 2 7 9
2 7 7 0 1 9 4 5 5 1 3 7 9 3 2 8 3 0 3 1 7 4 7 9 8 6 4 4 4 5 3 5 7 6 8 8 9 0 9 2 0 3 1 1 4 5 8 1 2 7 0 6 0 7 3
5 5 4 3 1 9 0 5 9 2 7 3 5 2 6 8 0 9 9 1 2 6 8 2 2 8 7 0 0 9 9 1 8 7 2 7 2 8 7 7 7 1 1 5 8 7 0 5 6 8 1 4 3 3 0
4 3 6 4 6 6 8 1 6 4 4 3 5 7 6 9 0 4 8 2 2 5 1 8 1 1 0 3 4 7 9 1 9 2 1 0 7 8 5 1 3 4 7 3 8 3 9 9 8 9 1 6 5 7 1
1 0 2 6 0 6 3 5 8 0 6 9 5 9 9 1 2 0 3 7 9 2 8 9 1 2 6 9 4 6 3 6 3 2 1 1 6 7 0 5 9 2 8 6 8 4 1 3 7 0 2 9 6 4 0
4 2 1 4 5 3 2 7 1 8 1 6 1 1 2 7 9 1 3 8 7 2 9 4 6 0 6 4 1 6 7 3 8 4 7 3 2 7 2 0 7 2 2 3 4 1 3 6 4 7 9 4 6 5 2
7 8 1 6 4 7 9 9 1 8 1 1 1 3 7 6 4 1 9 2 5 8 0 8 6 0 8 0 7 5 8 1 3 1 2 9 7 0 6 9 9 7 5 6 0 9 9 9 2 2 1 7 8 9 9
0 0 4 9 4 1 4 5 2 6 6 7 8 1 1 4 8 0 7 4 0 0 7 7 8 2 8 6 4 4 7 3 6 7 9 2 3 3 4 0 6 6 7 5 7 9 8 7 4 8 2 5 5 2 0
1 4 3 3 8 8 7 0 4 5 6 0 8 0 2 3 7 8 6 0 9 7 9 1 8 4 8 0 8 1 0 9 7 7 6 0 1 1 2 9 3 5 7 1 2 8 7 7 6 6 4 6 5 9 0
6 3 6 6 4 2 5 5 2 9 5 6 5 6 0 5 9 8 9 3 7 4 2 5 3 5 6 5 0 8 3 2 7 8 7 8 9 4 3 4 5 8 7 0 4 3 7 1 2 7 7 2 3 9 4
8 2 5 4 9 0 2 9 1 5 5 4 4 7 2 9 7 9 8 2 4 2 0 7 2 8 4 2 4 8 2 7 0 2 4 2 8 9 7 9 2 7 4 4 5 5 1 9 2 0 9 4 5 2 8
4 9 3 2 7 7 2 1 7 3 4 0 7 8 5 4 3 4 9 8 7 8 7 2 3 8 0 5 6 5 3 5 2 4 7 3 9 8 9 5 0 6 5 6 5 9 2 5 5 2 4 6 6 3 6
0 9 5 6 4 6 6 7 7 8 2 1 7 5 3 9 2 1 1 0 6 7 7 9 0 1 8 0 8 4 8 1 9 7 9 0 6 8 7 3 2 0 8 0 6 5 4 0 7 8 8 3 3 4 1
0 2 5 5 2 8 4 7 8 9 7 5 7 6 6 0 4 3 3 2 9 7 6 3 7 4 4 6 8 2 8 7 7 0 0 4 7 0 8 4 1 1 8 7 6 6 2 5 4 1 4 9 4 0 0
9 9 8 7 1 2 2 9 9 9 0 6 5 7 9 9 6 0 7 9 2 1 3 1 8 5 7 0 8 0 6 8 0 8 5 2 9 1 4 6 7 3 1 1 1 8 1 9 9 7 4 6 1 8 7
2 5 6 4 9 7 4 6 3 1 4 3 2 2 7 0 2 7 2 3 7 4 8 3 7 6 1 4 6 0 6 4 9 2 7 8 3 1 9 7 2 1 1 6 1 8 1 7 2 3 5 4 1 2 4
0 4 6 9 2 0 7 3 1 4 8 6 8 2 9 5 0 7 6 1 1 2 3 6 3 6 4 9 6 2 1 9 8 2 9 7 3 0 2 1 9 9 5 9 6 0 8 5 3 6 0 6 2 0 1
1 7 5 6 1 9 8 9 9 3 8 3 7 4 3 1 5 8 7 0 1 2 9 1 9 7 4 3 0 1 1 8 1 5 2 2 8 4 0 9 6 7 5 3 4 4 6 1 8 6 6 4 6 3 4
0 3 3 4 1 8 6 5 0 7 8 5 1 1 7 7 7 8 2 7 2 7 8 1 9 9 0 0 7 8 2 2 8 6 2 1 9 9 0 8 6 2 5 3 7 2 9 5 0 9 1 3 4 5 5
3 7 0 6 0 7 2 1 8 5 4 1 1 3 0 2 9 0 9 8 8 6 7 5 3 5 4 4 4 6 8 9 7 4 7 1 3 0 3 8 2 3 9 7 3 1 5 5 4 9 1 0 7 7 2
9 7 2 0 0 2 2 2 3 5 6 6 6 9 2 9 8 3 2 2 9 0 4 8 2 7 2 2 9 4 1 2 9 6 5 3 5 1 4 1 9 9 5 7 8 8 6 4 7 9 6 1 0 8 4
4 9 9 1 8 0 8 4 4 7 1 8 7 5 8 8 3 5 4 7 2 6 7 1 7 6 5 1 0 7 3 5 8 2 0 4 9 1 4 5 4 5 4 7 3 7 6 8 0 6 7 2 1 5 4
9 0 9 4 3 0 6 8 9 9 0 7 0 4 9 4 6 0 6 4 2 7 6 8 6 0 9 3 9 8 4 7 7 5 8 4 0 9 4 6 7 6 5 7 8 4 3 5 1 8 1 9 9 5 0
4 8 6 8 2 6 5 5 2 1 7 0 6 4 0 6 4 1 2 4 8 0 7 0 2 8 5 2 2 1 6 5 3 8 7 1 4 6 5 3 4 1 4 8 6 6 3 3 8 7 8 8 5 9 7
5 8 3 0 4 8 6 8 6 0 7 9 1 7 6 1 9 2 9 4 0 7 8 6 8 6 0 5 8 5 9 2 5 1 4 0 9 5 6 8 5 5 1 8 2 1 0 8 8 6 5 4 2 0 6
2 4 8 8 6 9 3 8 5 1 9 3 4 3 2 7 8 9 5 4 1 9 4 4 8 7 2 4 4 5 9 4 5 4 4 1 3 9 5 2 6 9 1 2 1 2 6 5 4 5 4 6 0 7 4
6 4 9 0 2 1 1 5 2 2 4 4 7 0 7 1 3 9 6 0 4 0 0 0 0 7 6 5 3 5 1 9 8 4 1 6 4 9 5 9 9 9 1 4 2 7 1 2 9 3 1 4 5 0 4
6 8 5 3 7 9 3 2 7 1 2 5 5 1 2 2 9 4 4 9 4 9 3 0 7 5 4 5 8 2 2 6 2 8 2 3 8 2 4 5 1 9 9 2 4 9 1 7 0 1 4 3 0 1 4
0 7 1 1 7 5 2 4 9 7 6 3 5 2 9 4 9 0 5 7 6 9 6 0 9 8 3 9 7 9 6 0 8 8 8 1 6 1 6 6 4 4 1 3 3 4 6 6 4 9 7 6 4 2 8
5 9 2 8 5 6 8 5 2 5 2 1 3 7 1 3 0 3 7 8 1 0 4 7 6 1 0 2 6 8 8 5 7 0 3 0 3 5 2 4 5 9 7 6 5 2 4 1 7 6 1 5 9 0 0
0 5 7 3 2 0 7 4 2 0 0 7 9 1 2 5 9 5 0 5 9 7 8 6 1 8 9 7 0 5 9 2 9 3 9 5 5 7 6 0 7 4 8 9 7 7 2 7 0 8 3 8 7 9 8
8 8 3 4 5 8 7 6 1 2 2 4 3 6 3 5 9 5 0 1 2 2 0 7 5 5 7 4 2 5 8 9 1 2 6 4 0 8 3 2 9 3 9 9 2 9 6 5 6 4 9 4 8 0 4
3 8 6 0 8 1 9 5 0 7 2 9 8 3 6 6 7 1 6 0 5 9 7 2 4 0 3 7 4 1 8 2 7 9 8 1 0 9 4 3 4 6 0 3 0 2 5 0 3 0 1 1 7 8 0
0 3 9 8 4 4 3 6 4 5 7 1 0 1 7 0 8 2 7 6 3 3 7 9 9 3 3 1 7 1 3 7 0 0 3 1 3 1 2 0 2 5 6 4 0 8 2 5 3 7 5 7 0 1 1
8 3 7 4 8 7 4 1 8 8 2 1 3 6 5 6 2 3 7 0 4 0 6 1 1 0 2 1 3 7 8 1 8 9 2 5 2 9 8 1 5 3 4 0 0 1 7 1 0 5 6 6 1 6 8
8 0 9 9 9 7 9 4 6 9 9 3 4 5 9 5 7 0 4 2 7 5 8 1 3 2 2 4 7 5 8 5 5 8 3 5 5 5 1 7 5 5 9 1 7 3 5 2 6 1 1 6 0 6 0
7 0 4 3 4 3 8 2 5 3 9 4 5 7 8 6 2 2 0 2 3 2 8 5 6 4 3 6 7 7 2 7 0 6 3 3 4 2 6 7 1 5 3 4 2 9 6 7 1 5 6 5 0 1 2
8 7 6 4 6 9 8 3 9 1 7 4 4 7 3 0 0 6 1 7 5 7 3 5 2 7 5 4 2 5 0 2 3 0 3 5 3 1 5 1 3 6 5 9 0 6 0 4 5 1 2 3 2 5 1', 'Test #1: Non-symmetric.
Test #2: Symmetric.
Test #3: Symmetric.
Test #4: Symmetric.
Test #5: Symmetric.
Test #6: Non-symmetric.
Test #7: Symmetric.
Test #8: Non-symmetric.
Test #9: Non-symmetric.
Test #10: Non-symmetric.
Test #11: Non-symmetric.
Test #12: Symmetric.
Test #13: Symmetric.
Test #14: Symmetric.
Test #15: Non-symmetric.
Test #16: Symmetric.
Test #17: Non-symmetric.
Test #18: Symmetric.
Test #19: Non-symmetric.
Test #20: Symmetric.
Test #21: Non-symmetric.
Test #22: Symmetric.
Test #23: Non-symmetric.
Test #24: Non-symmetric.
Test #25: Non-symmetric.
Test #26: Symmetric.
Test #27: Symmetric.
Test #28: Non-symmetric.
Test #29: Symmetric.
Test #30: Non-symmetric.
Test #31: Symmetric.');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (47, 11417, 'GCD', '11417 - GCD', 'https://onlinejudge.org/external/114/p11417.pdf', 2, '//uva11417
//uva11417
#include <iostream>
using namespace std;
int gcd(int x, int y){
	int r = 0;

    while (y != 0) {
        r = x % y;
        x = y;
        y = r;
    }

    return x;
}
int main() {
   int ans[507] = {0}, n;
   for (int i = 1; i < 507; i++) {
      ans[i] = ans[i - 1];
      for (int j = 1; j < i; j++)
        ans[i]+= gcd(i, j);
   }
   while (cin >> n) {
       if (n == 0)
          break;
       else
          cout << ans[n] << endl;
   }

   return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '10
100
500
2
3
4
5
6
7
8
14
15
16
19
28
52
63
88
90
104
149
203
249
389
399
401
402
403
499
498
497
496
495
494
493
490
491
491
491
491
492
492
492
477
476
475
468
467
466
465
464
463
462
461
460
459
458
457
456
455
454
480
481
429
428
449
448
447
446
452
421
441
440
439
438
422
423
424
425
426
432
431
430
488
488
488
500
500
500
492
384
293
488
378
485
500
500
0', '67
13015
442011
1
3
7
11
20
26
38
142
172
204
283
737
2987
4556
9690
10255
14006
30887
61277
96270
254403
269792
272912
274505
275627
439111
438613
436636
435300
432868
429394
427113
422487
422977
422977
422977
422977
425725
425725
425725
398925
397197
394241
382855
379123
378657
377728
375448
373176
372714
369081
368621
365841
363627
362714
362258
359014
356544
404916
406260
316337
314141
348344
347896
345016
343978
354587
304263
336990
334638
331298
330860
305104
306634
308310
310030
311719
322088
318632
318202
418250
418250
418250
442011
442011
442011
425725
248620
137071
418250
241435
413159
442011
442011', '2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
30
50
100
200
300
400
500
499
498
497
496
495
494
493
492
491
490
489
488
487
486
485
484
483
482
481
480
479
478
477
476
475
474
473
472
471
470
469
468
467
466
465
464
463
462
461
460
459
458
457
456
455
454
453
452
451
450
449
448
447
446
445
444
443
442
441
440
439
438
437
436
435
434
433
432
431
430
500
500
0', '1
3
7
11
20
26
38
50
67
77
105
117
142
172
204
220
265
283
335
870
2725
13015
59874
145817
272512
442011
439111
438613
436636
435300
432868
429394
427113
425725
422977
422487
419386
418250
416318
415832
413159
411907
409663
407221
406260
404916
400356
399878
398925
397197
394241
392311
390430
389118
387250
386156
384115
382855
379123
378657
377728
375448
373176
372714
369081
368621
365841
363627
362714
362258
359014
356544
355639
354587
353239
351989
348344
347896
345016
343978
343089
341941
339465
339023
336990
334638
331298
330860
329123
327895
326595
324465
322520
322088
318632
318202
442011
442011');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (48, 11461, 'Square Numbers', '11461 - Square Numbers', 'https://onlinejudge.org/external/114/p11461.pdf', 1, '//uva11461
#include <iostream>
#include <cmath>
using namespace std;
  
int main() {
    ios_base::sync_with_stdio(0);
    cin.tie(0);
    int a, b;
    while (cin >> a >> b && a + b){
        int n1 = sqrt(a);
        int n2 = sqrt(b);
        if (n1*n1 != a) n1++;
        cout << n2 - n1 + 1 << \"\\n\";
    }
    return 0;
}', '1 4
1 10
0 0', '2
3', '未考過此題', '未考過此題', '未考過此題', '未考過此題');
INSERT INTO `uva_codes` (`id`, `serial`, `title`, `show`, `topic_url`, `star`, `code`, `data_input`, `data_output`, `data_a_input`, `data_a_output`, `data_b_input`, `data_b_output`) VALUES (49, 12019, 'A - Doom`s Day Algorithm', '12019 - A - Doom`s Day Algorithm', 'https://onlinejudge.org/external/120/p12019.pdf', 1, '//uva12019
#include <iostream>
using namespace std;

int main()
{
	char week[10][10] = {\"Monday\", \"Tuesday\", \"Wednesday\", \"Thursday\", \"Friday\", \"Saturday\", \"Sunday\"};
	int month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	int n;

	cin >> n;
	while(n--)
	{
		int mm, dd;
		cin >> mm >> dd;

		int w = 4;
		for(int i = 1; i < mm; i++)
			w += month[i-1];

		w = (w + dd) % 7;
		cout << week[w] << endl;
	}
	return 0;
}', '如果看到這行就表示沒有此測資', '如果看到這行就表示沒有此測資', '32
1 6
2 28
4 5
5 26
8 1
11 1
12 25
12 31
1 1
1 3
1 4
1 30
2 5
2 26
3 3
3 30
4 1
4 30
5 9
5 31
6 11
6 26
7 20
7 31
8 31
9 1
9 28
10 31
11 22
11 30
12 1
12 27', 'Thursday
Monday
Tuesday
Thursday
Monday
Tuesday
Sunday
Saturday
Saturday
Monday
Tuesday
Sunday
Saturday
Saturday
Thursday
Wednesday
Friday
Saturday
Monday
Tuesday
Saturday
Sunday
Wednesday
Sunday
Wednesday
Thursday
Wednesday
Monday
Tuesday
Wednesday
Thursday
Tuesday', '34
1 11
9 1
1 31
2 27
12 7
9 30
3 1
8 8
5 8
9 5
2 3
5 3
3 13
8 22
4 10
9 23
11 14
12 31
7 1
8 12
5 6
7 23
6 15
3 8
6 30
3 7
11 15
9 2
6 20
2 8
1 31
3 31
5 31
10 10', 'Tuesday
Thursday
Monday
Sunday
Wednesday
Friday
Tuesday
Monday
Sunday
Monday
Thursday
Tuesday
Sunday
Monday
Sunday
Friday
Monday
Saturday
Friday
Friday
Friday
Saturday
Wednesday
Tuesday
Thursday
Monday
Tuesday
Friday
Monday
Tuesday
Monday
Thursday
Tuesday
Monday');
