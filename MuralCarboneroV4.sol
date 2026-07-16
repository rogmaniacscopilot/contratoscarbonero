// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MuralCarboneroV4 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    
    // Dirección de la Server Wallet de Thirdweb autorizada
    address public constant THIRDWEB_WALLET = 0x65E17C4BFdFA3f18bae1c8504e41D6dDF648e5d5;

    string public ultimoAliento;
    uint256 public totalMensajes;

    event NuevoMensajeAvisado(address indexed remitente, string mensaje);

    struct Mensaje {
        address remitente;
        string texto;
        bool censurado;
    }

    mapping(uint256 => Mensaje) public historialMensajes;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) initializer public {
        __Ownable_init(initialOwner);
    }

    // Escritura estrictamente protegida: solo el Owner del Proxy o la Server Wallet de Thirdweb
    function dejarMensaje(string memory _nuevoMensaje) public payable {
        require(
            msg.sender == owner() || msg.sender == THIRDWEB_WALLET,
            "No tienes permisos para escribir en el mural carbonero"
        );

        ultimoAliento = _nuevoMensaje;
        historialMensajes[totalMensajes] = Mensaje({
            remitente: msg.sender,
            texto: _nuevoMensaje,
            censurado: false
        });
        emit NuevoMensajeAvisado(msg.sender, _nuevoMensaje);

        totalMensajes += 1;
    }

    function censurarMensaje(uint256 _idMensaje) public onlyOwner {
        require(_idMensaje < totalMensajes, "Ese mensaje no existe");
        require(!historialMensajes[_idMensaje].censurado, "Ya esta censurado");

        historialMensajes[_idMensaje].texto = "Mensaje eliminado por el administrador";
        historialMensajes[_idMensaje].censurado = true;
    }

    receive() external payable {}

    function _authorizeUpgrade(address newImplementation) internal onlyOwner override {}
}