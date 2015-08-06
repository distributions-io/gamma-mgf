using Distributions
using JSON

alpha = 5
beta = 7
d = Gamma( alpha, 1/beta )

x = [ -5, -2.5, 0, 2.5, 5 ]

dmgf(t) = mgf(d, t )
y = map( dmgf, x )
println( y )

data = Dict([
	("alpha", alpha),
	("beta", beta),
	("data", x),
	("expected", y)
])

outfile = open("./test/fixtures/partial.json", "w")
JSON.json(data)

write( outfile, JSON.json(data) )
