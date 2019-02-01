using Images.data, Images.copyproperties, Images.load, Images.save

transa(c) = float(c.r)+ float(c.g)+ float(c.b)
transb(c) = c.r
algorithm = PartialQuickSort(1)
#algorithm = QuickSort
i = load("lock.bmp")
#save("lock.bmp", copyproperties(i, data(i)))

save("lock.bmp", copyproperties(i, sort(sort(data(i), 2, alg=algorithm,  by=x->x.g, rev=rand(Bool)), 1, alg=algorithm,  by=x->transb(x), rev=rand(Bool))))

#sort(data(i), 2, alg=PartialQuickSort(10000), by=x->transb(x))
