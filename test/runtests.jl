using MyStatsPackage # here it is ok to use, don't put it in your "debug"-convenience setup.jl
include("setup.jl")


@testset "statistics functions" begin
    include("statistics_functions.jl")
end