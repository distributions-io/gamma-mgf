using Distributions
using JSON

alpha = 9
beta = 6
d = Gamma( alpha, 1/beta )

x = linspace( -6, 4, 100 )

dmgf(t) = mgf(d, t )
y = map( dmgf, x )
println( y )

data = Dict([
	("alpha", alpha),
	("beta", beta),
	("data", x),
	("expected", y)
])

outfile = open("./test/fixtures/deepset.json", "w")
JSON.json(data)

write( outfile, JSON.json(data) )
