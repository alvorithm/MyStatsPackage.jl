using ProgressMeter

function rse_sum(v)
    @assert all(!isnan, v)
    res = 0
    @showprogress for el in v
        res = res + el
    end
    return res
end



function rse_mean(v; ℓ=length(v))
    @assert all(!isnan, v)
    @assert ℓ > 0
    return rse_sum(v)/ℓ
end



function rse_std(v; μ=rse_mean(v), ℓ=length(v))
    @assert all(!isnan, v)
    @assert ℓ > 0
    var = sum((v.-μ).^2) /(ℓ-1)
    return sqrt(var)
end



function rse_tstat(v; ℓ=length(v), μ=rse_mean(v), σ=rse_std(v))
    @assert ℓ > 0
    @assert σ > 0

    μ/(σ/sqrt(ℓ))
end


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