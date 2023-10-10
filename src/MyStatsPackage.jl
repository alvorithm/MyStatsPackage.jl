module MyStatsPackage

greet() = print("Hello World!")
include("statistics_functions.jl")
export rse_mean, rse_std, rse_tstat, StatResult
end # module MyStatsPackage
