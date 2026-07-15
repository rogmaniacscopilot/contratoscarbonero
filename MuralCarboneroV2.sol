// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MuralCarboneroV2 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    
    // --- 1. VARIABLES ORIGINALES (¡INTOCABLES!) ---
    string public ultimoAliento;
    uint256 public totalMensajes;

    // --- 2. EL MEGÁFONO PARA TELEGRAM ---
    // Declaramos el evento. Guarda la dirección del que escribió y el mensaje.
    event NuevoMensajeAvisado(address indexed remitente, string mensaje);

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address initialOwner) initializer public {
        __Ownable_init(initialOwner); 
    }

    // --- 3. FUNCIONES ---
    function dejarMensaje(string memory _nuevoMensaje) public payable {
        ultimoAliento = _nuevoMensaje;
        totalMensajes += 1;

        // ¡DISPARAMOS EL EVENTO! El puente va a escuchar esto.
        emit NuevoMensajeAvisado(msg.sender, _nuevoMensaje);
    }

    receive() external payable {}

    function _authorizeUpgrade(address newImplementation) internal onlyOwner override {}
}