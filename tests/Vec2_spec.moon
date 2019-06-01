-- Have to deal with damn floating-point comparisons
round = (num, numDecimalPlaces)->
  mult = 10^(numDecimalPlaces or 0)
  math.floor(num * mult + 0.5) / mult


describe "Vec2", ->
    before_each setup ->
        export Vec2 = require "src.Vec2"
        math.randomseed os.time!
    
    it "should be imported", ->
        assert.is.truthy Vec2

    describe "non-null vector", ->
        vector = Vec2 math.random(-100, 100), math.random(-100, 100)
        other_vector = Vec2 math.random(-100, 100), math.random(-100, 100)

        it "should have a nonzero length", ->
            assert.not.equals vector\length!, 0
        it "should calculate length correctly", ->
            assert.near vector\length!, math.sqrt(vector.x^2 + vector.y^2), 10^-4
        it "should implement addition", ->
            sum = vector + other_vector
            assert.truthy sum
            assert.near vector.x + other_vector.x, sum.x, 10^-6
            assert.near vector.y + other_vector.y, sum.y, 10^-6
        it "should implement subsctraction", ->
            diff = vector - other_vector
            assert.truthy diff
            assert.near vector.x - other_vector.x, diff.x, 10^-6
            assert.near vector.y - other_vector.y, diff.y, 10^-6
        it "should implement multiplication with scalar", ->
            mul = math.random -10, 10
            multiplied_vector = vector * mul
            assert.truthy multiplied_vector
            assert.near multiplied_vector.x, vector.x * mul, 10^-6
            assert.near multiplied_vector.y, vector.y * mul, 10^-6
            assert.near multiplied_vector\length!, math.abs(mul) * vector\length!, 10^-6
        it "should implement scalar multiplication", ->
            mul = vector * other_vector
            assert.truthy mul
            assert.is_number mul
            assert.near mul, vector.x * other_vector.x + vector.y * other_vector.y, 10^-6
    describe "a normalized vector", ->
        original = Vec2 math.random(-100, 100), math.random(-100, 100)
        normalized = original\normalize!
        -- zero length is HIGHLY unlikely
        it "should have length 1", ->
            assert.near normalized\length!, 1, 10^-6
        it "should be paralel to the original", ->
            -- test it by adding them & checking lengths
            assert.near normalized\length! + original\length!, (normalized+original)\length!, 10^-6