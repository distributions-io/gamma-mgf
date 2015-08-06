using Distributions
using JSON

alpha = 3
beta = 6
d = Gamma( alpha, 1/beta )

x = linspace( -1, 1, 100 )

dmgf(t) = mgf(d, t )
y = map( dmgf, x )
println( y )

data = Dict([
	("alpha", alpha),
	("beta", beta),
	("data", x),
	("expected", y)
])

outfile = open("./test/fixtures/typedarray.json", "w")
JSON.json(data)

write( outfile, JSON.json(data) )
