const PokemonBase = artifacts.require("PokemonBase");

module.exports = function(deployer) {
  deployer.deploy(PokemonBase);
};
