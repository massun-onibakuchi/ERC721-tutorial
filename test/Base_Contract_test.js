const PokemonBase = artifacts.require('PokemonBase')

contract('PokemonBase', (accounts) => {
    before(async () => {
        pokemonbase = await PokemonBase.deployed()
    })

    describe('deployment', async () => {
        it('deploys successfully', async () => {
            const address = await pokemonbase.address
            assert.notEqual(address, 0x0)
            assert.notEqual(address, '')
            assert.notEqual(address, null)
            assert.notEqual(address, undefined)
        })

        it('create Pokemon test', async () => {
            pokemonbase.createPokemon("pokename",3,accounts[0])
            console.log("pokemons.length  = ",pokemons.length);
            assert.equal(pokemonbase.pokemons[0].name == "pokename");
            assert.equal(pokemonbase.pokemons[0].level == 3);
            assert.equal(pokemonbase.pokemons[0].previousOwner == accounts[0]);
        })

    })
})