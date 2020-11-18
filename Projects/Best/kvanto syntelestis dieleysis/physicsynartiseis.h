#ifndef SYNARTISEIS
#define SYNARTISEIS

int add(int x, int y){
    int z = x+y;
    return z;
}

double parameters[3] = {5000, 100, 20};/*parameters*/
/*#define yolo 100
double m_0=2000;
double t_0=0;
double t_start=0;
double t_end = m_0/(yolo + 0.);/*interval borders*/

double f_gravity(double x, double v)
{

	double g = parameters[0], R = parameters[1];
	return -(g*pow(R, 2)) / (v*pow(R + x, 2) + 0.);
}

double T_dieleysis(double V, double E, double L, double m)
{

	double k,k0,n,g,hbarc;
	k0 = E-V;
    k = k0>0. ? k0 : -k0;
    hbarc=0.1973269804;		//symperilambanetai to c^2 gia thn maza
    n = sqrt(2.*m/pow(hbarc,2));
    g = k0>0. ? 4.*E*k/(pow(V*sin(n*L*sqrt(k)),2.)+4.*E*k) : 4.*E*k/(pow(V*sinh(n*L*sqrt(k)),2.)+4.*E*k)   ;
	return g;
}

double T_dieleysis_proseggisi(double V, double E, double L, double m)
{
	double g, g0, n, r, hbarc, c;
	g0 = V - E;
	g = g0 < 0. ? -g0 : g0;
	hbarc = 0.1973269804;		//symperilambanetai to c^2 gia thn maza
	n = sqrt(2. * m * g / pow(hbarc, 2));
	r = 16 * E / V * (1 - E / V)*exp(-2 * n * L);
	return r;
}


void Milne_Simpson(double (*f)(double t, double y), double t_0, double y_0,
	double t_end, int Np, double *t, double *y)
	/*solves differential equations using the Milne- Simpson method*/
{
    FILE* fp=fopen("NC_diffeq_1.txt", "w");

	double h = (t_end - t_0) / (Np + 0.);/*the step*/
	double k1, k2, k3, k4;/*this will be needed for the 4th order RK*/
	t[0] = t_0; y[0] = y_0;/*starting points*/
	for (int j = 1; j < 4; j++) {/*applying RK to find the first 4 points*/
		t[j] = t[0] + h * j;
		k1 = f(t[j - 1], y[j - 1]);
		k2 = f(t[j - 1] + h * 0.5, y[j - 1] + (h*0.5)*k1);
		k3 = f(t[j - 1] + h * 0.5, y[j - 1] + (h*0.5)*k2);
		k4 = f(t[j - 1] + h, y[j - 1] + h * k3);

		y[j] = y[j - 1] + (h / (6 + 0.))*(k1 + 2 * k2 + 2 * k3 + k4);
	}

	for (int i = 4; i <= Np; i++) {
		t[i] = t[0] + h * i;

		y[i] = y[i - 4] + ((4 * h) / (3 + 0.))*(2 * f(t[i - 1], y[i - 1]) -
			f(t[i - 2], y[i - 2]) + 2 * f(t[i - 3], y[i - 3]));
		/*prediction using Milne*/
		y[i] = y[i - 2] + (h / (3 + 0.))*(f(t[i], y[i]) +
			4 * f(t[i - 1], y[i - 1]) + f(t[i - 2], y[i - 2]));
		/*correction using Simpson*/
		 printf("\n t (sec)\t v (km/s)\n %lf\t %lf", t[i], y[i]);
         fprintf(fp, "%lf \t,\t %lf\n", t[i], y[i]);
	}
	 fclose(fp);

}


#endif // SYNARTISEIS
