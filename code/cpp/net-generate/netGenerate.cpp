// netGenerate.cpp : Defines the entry point for the console application.
//

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
using namespace std;


int main(int argc, char* argv[])
{
	int i = 0, j = 0, k = 0, ln=0,
		ifnPara[3] = { 0, 0, 0 }, ifname = 10, 
		ufnPara[3] = { 0, 0, 0 }, ufname = 16676,
		yfnPara[3] = { 0, 0, 0 }, yfname = 01;
	string Http = "http://content1.erosberry.com", 
		Hweb="met-art.com",cfname="movie",fmat="jpg";

	//cout <<argc << endl;

	for (i = 1; i < argc; i++) {
		if (!strcmp(argv[i], "-ht")) Http = argv[++i];
		else if (!strcmp(argv[i], "-hw")) Hweb = argv[++i];
		else if (!strcmp(argv[i], "-fn")) cfname = argv[++i];
		else if (!strcmp(argv[i], "-ft")) fmat = argv[++i];
		else if (!strcmp(argv[i], "-ln")) ln = atoi(argv[++i]);
		else if (!strcmp(argv[i], "-ifn")) {
			for (j = 0; j < 3; j++) {
				ifnPara[j] = atoi(argv[++i]);
				//cout << ifnPara[j] << endl;
			}
			if (ifnPara[0] > ifnPara[1]) {
				j = ifnPara[0];
				ifnPara[0] = ifnPara[1];
				ifnPara[1] = j;
			}
		}
		else if (!strcmp(argv[i], "-ufn")) {
			for (k = 0; k < 3; k++) {
				ufnPara[k] = atoi(argv[++i]);
				//cout << ufnPara[k] << endl;
			}
			if (ufnPara[0] > ufnPara[1]) {
				k = ufnPara[0];
				ufnPara[0] = ufnPara[1];
				ufnPara[1] = k;
			}
		}
		else if (!strcmp(argv[i], "-yfn")) {
			for (k = 0; k < 3; k++) {
				yfnPara[k] = atoi(argv[++i]);
				//cout << ufnPara[k] << endl;
			}
			if (yfnPara[2] < yfnPara[1]) {
				k = yfnPara[2];
				yfnPara[2] = yfnPara[1];
				yfnPara[1] = k;
			}
		}

		//else if (!strcmp(argv[i], "-h")) {
		//	usage(); exit(0);
		//}
		else {
			fprintf(stderr, "Error: Command-line argument '%s' not recognized.\n",
				argv[i]);
			exit(-1);
		}
	}

	//cout << cfname<< fmat<<endl;
	// for jpg downloda webstie generating----------------
	// for this style website :http://content1.erosberry.com/sexart.com/2804/06.jpg
	if (ln==2){
		for (k = ufnPara[0]; k <= ufnPara[1]; k++) {
			for (j = ifnPara[0]; j <= ifnPara[1]; j++) {

				cout << Http << "/" << Hweb << "/";

				if (k == 0){
					for (i = 0; i < ufnPara[2]; i++) { 
						cout << "0"; 
					}
				}
				else{
					i = 1;
					while (i*k < pow(10, ufnPara[2]-1)){
						cout << "0";
						i = i * 10;
					}
					cout << k;
				}

				cout << "/";

				if (j == 0){
					for (i = 0; i < ifnPara[2]; i++) {
						cout << "0";
					}
				}
				else{
					i = 1;
					while (i*j < pow(10, ifnPara[2] - 1)){
						cout << "0";
						i = i * 10;
					}
					cout << j;
				}
				cout << "." << fmat << endl;
				}

			}
		}


	// for this style website :http://img.11rtys.com/201405/8/1.jpg
	else if (ln == 3){
		for (i = yfnPara[1]; i <= yfnPara[2]; i++) {
			for (k = ufnPara[0]; k <= ufnPara[1]; k++) {
				for (j = ifnPara[0]; j <= ifnPara[1]; j++) {

					cout << Http << "/" << yfnPara[0];

					if (i < 10) { cout << "0"; }
					cout << i << "/";

					cout << k;

					cout << "/";

					cout << j;

					cout << "." << fmat << endl;
				}

			}
		}
	}

	// for this style website :http://img.11rtys.com/20080701/309/22.jpg
	else if (ln == 4){
		for (k = ufnPara[0]; k <= ufnPara[1]; k++) {
			for (j = ifnPara[0]; j <= ifnPara[1]; j++) {

				cout << Http << "/" << Hweb << "/";

				cout << k;

				cout << "/";

				cout << j;

				cout << "." << fmat << endl;
			}

		}
	}
	// for movie.mp4 downloda webstie generating----------------
	else if (ln==1){
		for (k = ufnPara[0]; k <= ufnPara[1]; k++) {
			for (j = ifnPara[0]; j <= ifnPara[1]; j++) {

				cout << Http << "/videos/" << Hweb << "/";

				if (k == 0){
					for (i = 0; i < ufnPara[2]; i++) {
						cout << "0";
					}
				}
				else{
					i = 1;
					while (i*k < pow(10, ufnPara[2] - 1)){
						cout << "0";
						i = i * 10;
					}
					cout << k;
				}

				cout << "/"<< cfname;


				cout << "." << fmat << endl;
			}

		}
	}
	else{
		cout << Http << "/" << Hweb << "/" << ufname << "/" << ifname << "." << fmat << endl;
		cout << Http << "/" << Hweb << "/" << ufname << "/" << cfname << "." << fmat << endl;
	}

	return 0;
}

