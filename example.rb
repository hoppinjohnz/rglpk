require 'rglpk'
# The same Brief Example as found in section 1.3 of glpk-4.44/doc/glpk.pdf.
# maximize
#   z = 10 * x1 + 6 * x2 + 4 * x3
# s.t.
#   p:      x1 +     x2 +     x3 <= 100
#   q: 10 * x1 + 4 * x2 + 5 * x3 <= 600
#   r:  2 * x1 + 2 * x2 + 6 * x3 <= 300
#           x1 >= 0, x2 >= 0, x3 >= 0
#    
p = Rglpk::Problem.new
p.name = "sample"
p.obj.dir = Rglpk::GLP_MAX

rows = p.add_rows(3)
rows[0].name = "p"
rows[1].name = "q"
rows[2].name = "r"

rows[0].up(100.0)
rows[1].up(600.0)
rows[2].up(300.0)

cols = p.add_cols(3)
cols[0].name = "x1"
cols[1].name = "x2"
cols[2].name = "x3"

cols[0].lo(0.0)
cols[1].lo(0.0)
cols[2].lo(0.0)

p.obj.coefs = [10, 6, 4]

p.set_matrix([
 1, 1, 1,
10, 4, 5,
 2, 2, 6
])

p.simplex
z = p.obj.get
x1 = cols[0].get_prim
x2 = cols[1].get_prim
x3 = cols[2].get_prim

printf("z = %g; x1 = %g; x2 = %g; x3 = %g\n", z, x1, x2, x3)
#=> z = 733.333; x1 = 33.3333; x2 = 66.6667; x3 = 0
