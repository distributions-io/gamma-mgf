using Distributions
using JSON

alpha = 1
beta = 1
d = Gamma( alpha,beta )

x = linspace( .5, -100, 100 )

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
