module MyStatsPackage

function printOwner()
    println("alvorithm")
end


include("statistics_functions.jl")
export rse_sum, rse_mean, rse_std, rse_tstat, StatResult
end # module MyStatsPackage
