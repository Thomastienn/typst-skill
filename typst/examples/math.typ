// LaTeX-style math, written the Typst way.
#import "@preview/physica:0.9.8": *
#set page(width: 16cm, height: auto, margin: 1cm)
#set math.equation(numbering: "(1)")

Inline: $x^2 + y^2 = r^2$, $alpha, beta, Gamma$, $x in RR$, $f: A -> B$.

$ integral_0^infinity e^(-x^2) dif x = sqrt(pi) / 2 $ <gauss>

$ sum_(k=1)^n k = (n(n+1)) / 2, quad lim_(x -> 0) (sin x) / x = 1 $

// Aligned multi-line (LaTeX align): & aligns, \ breaks.
$ (a + b)^2 &= a^2 + 2 a b + b^2 \
            &>= 4 a b $

$ f(x) = cases(x^2 &"if" x >= 0, -x &"otherwise") $

$ A = mat(1, 2; 3, 4), quad bold(v) = vec(x, y, z), quad det mat(a, b; c, d) = a d - b c $

$ hat(x), tilde(y), overline(z), arrow(F), dot(q), dot.double(q), abs(x), norm(bold(v)), floor(x), ceil(y) $

$ op("argmax")_(theta) cal(L)(theta), quad binom(n, k), quad upright(d) x $

// physica: derivatives, bra-ket, etc.
$ dv(f, x), quad pdv(f, x, y), quad braket(psi, phi), quad grad dot vb(E) = rho / epsilon_0 $

Ref: @gauss.
