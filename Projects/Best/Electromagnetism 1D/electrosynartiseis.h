#ifndef SYNARTISEIS
#define SYNARTISEIS

void Milne_Simpson (double (*f)(double t, double y), double t_0, double y_0,
double t_end, int Np, double *t, double *y)
/*solves differential equations using the Milne- Simpson method*/
{
double h = (t_end-t_0)/(Np+0.);/*the step*/
double k1, k2, k3, k4;/*this will be needed for the 4th order RK*/
t[0]=t_0; y[0]=y_0;/*starting points*/
 for(int j=1; j<4; j++){/*applying RK to find the first 4 points*/
    t[j] = t[0] + h*j;
    k1 = (*f)(t[j-1], y[j-1]);
    k2 = (*f)(t[j-1] + h*0.5, y[j-1] + (h*0.5)*k1);
    k3 = (*f)(t[j-1] + h*0.5, y[j-1] + (h*0.5)*k2);
    k4 = (*f)(t[j-1] + h, y[j-1] + h*k3);

    y[j] = y[j-1] + (h/(6+0.))*(k1 + 2*k2 + 2*k3 + k4);
    }
 for(int i=4; i<=Np; i++){
    t[i] = t[0] + h*i;
    y[i] = y[i-4] + ((4*h)/(3+0.))*(2*(*f)(t[i-1], y[i-1]) -
    (*f)(t[i-2], y[i-2]) + 2*(*f)(t[i-3], y[i-3]));
    /*prediction using Milne*/
    y[i] = y[i-2] + (h/(3+0.))*((*f)(t[i], y[i]) +
    4*(*f)(t[i-1], y[i-1]) + (*f)(t[i-2], y[i-2]));
    /*correction using Simpson*/
    }
}


void Potential_1D (double (*f)())


#endif // SYNARTISEIS
