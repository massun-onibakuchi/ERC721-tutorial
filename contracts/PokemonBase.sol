pragma solidity ^0.5.4;
import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721Pausable.sol";
// import "../node_modules/@openzeppelin/contracts/access/Roles.sol";

contract PokemonBase is ERC721Full,ERC721Pausable {
    // using Roles for Roles.Role;

    // Roles.Role private _minters;

    constructor() public ERC721Full("Pokemon","PKN"){
        adminAddress = _msgSender();
    }

    address private adminAddress;
    struct Pokemon{
        string name;
        uint8 level;
        // address[] previousOwner;
        // address seller;
        // address buyer;
        // bool onSale;
    }
    Pokemon[] public pokemons;

    function createPokemon(string memory _name,uint8 _level,address _to) public onlyAdmin(adminAddress) returns(uint){

        // Pokemon memory _token = Pokemon({
        // It is difficult to initialize an array type in a struct in this way
        //     name: _name,
        //     level:_level,
        //     previousOwner:
        // });
        // Ref:https://stackoverflow.com/questions/35743893/how-do-i-initialize-an-array-in-a-struct

        // uint _id = pokemons.length ++;
        // pokemons[_id].name = _name;
        // pokemons[_id].level = _level;
        // pokemons[_id].previousOwner.push(_msgSender());

        // 1
        // address[] memory _previousOwner;
        uint  _id = pokemons.length;
        // _previousOwner[0] = _msgSender();
        Pokemon memory _token = Pokemon(_name,_level);
        // Pokemon memory _token = Pokemon(_name,_level,_previousOwner);
        pokemons.push(_token);
        //2
        // address[] memory _previousOwner
        // _previousOwner.push(_msgSender());

        super._mint(_to,_id);
        return _id;
    }

    function releasePokemon(uint256 id) external {
        super._burn(id);
    }

    modifier onlyAdmin(address _adminAddress){
        require(_msgSender() == _adminAddress,"You are not the admin");
        _;
    }
    function setAdminAddress(address _address) public onlyAdmin(adminAddress){
        adminAddress = _address;
    }
    function lookAdminAddress() external view onlyAdmin(adminAddress) returns(address){
       return adminAddress;
    }


}