// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MuralCarbonero is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    
    // --- 1. TUS VARIABLES ORIGINALES ---
    string public ultimoAliento;
    uint256 public totalMensajes;

    // --- 2. CONFIGURACIÓN DEL PROXY ---
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    // Esta función reemplaza al "constructor" normal. Define que vos sos el dueño.
    function initialize(address initialOwner) initializer public {
        __Ownable_init(initialOwner); 
    }

    // --- 3. TUS FUNCIONES ORIGINALES ---
    // Tu función para dejar mensajes (queda igual)
    function dejarMensaje(string memory _nuevoMensaje) public payable {
        ultimoAliento = _nuevoMensaje;
        totalMensajes += 1;
    }

    // Tu función para recibir ETH (queda igual)
    receive() external payable {}

    // --- 4. SEGURIDAD DEL PROXY ---
    // Esta es la "llave" que permite que en el futuro subas una V2. 
    // Como tiene "onlyOwner", nadie más que vos puede cambiar el contrato.
    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}
}