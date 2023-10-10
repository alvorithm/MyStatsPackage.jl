
@testset "unit tests" begin
    @testset "rse_sum" begin
        @test rse_sum(1:36) == 666
        @test_throws AssertionError rse_sum([NaN, 3, 2])
    end

    @testset "rse_mean" begin
        @test rse_mean(-15:17) == 1
        @test rse_mean([1,3,6]) ≈ 3.333 atol=1e-3
      
    end

    @testset "rse_std" begin
        @test rse_std(-50:12) ≈ 18.3303 atol=1e-4
    end

    @testset "rse_tstat" begin
        @test_throws AssertionError rse_tstat(-50:12; σ = 0)
        # test_throws does not work with broken=true, cf.
        # https://discourse.julialang.org/t/whats-the-strategy-for-marking-a-broken-test-that-you-expect-to-throw-when-its-not-broken/64385/4
        # @test_throws DomainError rse_tstat([1,5,7]; ℓ=1.766) broken=true
    end

end

@testset "efficient statistics" begin
    
    data = [43, 32, 167, 18, 1, 209]
    
    μ = rse_mean(data)
    σ = rse_std(data)
    ℓ = length(data)

    # Expected result
    expected_tstat_cached_all = 2.2023874

    # Actual result
    # TODO: check the whole chain: mu cached, get 
    actual_tstat_cached_all = rse_tstat(data; μ=μ, σ=σ, ℓ=ℓ)
    
    # Test
    @test actual_tstat_cached_all ≈ expected_tstat_cached_all atol=1e-7
end