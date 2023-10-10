using ProgressMeter

function rse_sum(v)
    res = 0
    @showprogress for el in v
        res = res + el
    end
    return res
end

# rse_sum(1:36) == 666


function rse_mean(v; ℓ=length(v))
    return rse_sum(v)/ℓ
end

# rse_mean(-15:17) == 1


function rse_std(v; μ=rse_mean(v), ℓ=length(v))
    var = sum((v.-μ).^2) /(ℓ-1)
    return sqrt(var)
end

# rse_std(1:3) == 1.0


function rse_tstat(v; ℓ=length(v), μ=rse_mean(v), σ=rse_std(v))
    μ/(σ/sqrt(ℓ))
end

# rse_tstat(2:3;σ = 4)


struct StatResult
    x::Vector
    n::Int64
    std::Float64
    tvalue::Float64
end

function StatResult(x)
    ℓ = length(x)
    μ = rse_mean(x;ℓ=ℓ)
    σ = rse_std(x; ℓ=ℓ,μ=μ)
    τ = rse_tstat(x;ℓ=ℓ,μ=μ,σ=σ )
    return StatResult(x, ℓ, σ, τ)
end

# overload of length (defers to the length of the /vector/, not its stats)
import Base: length
function Base.length(s::StatResult)
    s.n
end


import Base: show;
function Base.show(io::IO, s::StatResult)
    println(io, "Std. $(s.std) -- t statistic $(s.tvalue) of a $(s.n)-element vector.")
end