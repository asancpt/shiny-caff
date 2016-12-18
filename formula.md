The pharmacokinetic parameters from the paper were derived and used in the app as follows:

$$ 
\begin{split}
T_{max}\ (hr) & = \frac{ln(K_a) - ln(K_e)}{K_a - K_e} \\
C_{max}\ (mg/L) & = \frac{Dose}{V} \cdot \frac{K_a}{K_a - K_e} \cdot (e^{-K_e \cdot  T_{max}} - e^{-K_a \cdot T_{max}}) \\
AUC\ (mg \cdot hr / L)  & = \frac{Dose}{CL} \\
t_{1/2}\ (hr) & = \frac{0.693}{K_e} \\
CL\ (mg/L) & = 0.09792 \cdot Body Weight \cdot e^{\eta1} \\
V\ (L) & = 0.7219 \cdot Body Weight \cdot e^{\eta2} \\
Ka\ (1/hr) & = 4.268 \cdot e^{\eta3} \\
Ke\ (1/hr) & = \frac{CL}{V}  \\
   \begin{bmatrix}
         \eta_1 \\
         \eta_2 \\
         \eta_3
    \end{bmatrix}
    \sim & MVN \bigg(
   \begin{bmatrix}
         \eta_1 \\
         \eta_2 \\
         \eta_3
    \end{bmatrix}
    , 
   \begin{bmatrix}
         0.1599 & 6.095 \cdot 10^{-2} & 9.650 \cdot 10^{-2} \\
         6.095 \cdot 10^{-2} & 4.746 \cdot 10^{-2} & 1.359 \cdot 10^{-2} \\
         9.650 \cdot 10^{-2} & 1.359 \cdot 10^{-2} & 1.004
    \end{bmatrix}
    \bigg)
\end{split}
$$