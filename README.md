# 💛🖤 Mural Carbonero

**Inmortalizando la pasión en la blockchain con Cero Fricción.**

Proyecto desarrollado para la **Hackathon Ethereum Uruguay 2026**.
El Mural Carbonero es una pizarra digital descentralizada en Ethereum (Testnet Sepolia) que le permite a los hinchas dejar un mensaje inmutable en la blockchain utilizando Telegram, sin necesidad de saber usar una wallet ni pagar comisiones de gas.

---

## 🎥 Pitch Video y Enlaces
* **Demo Video (5 min)
* **Contrato Inteligente (Sepolia):** [0xB4047FD588b8477491A571Bd2522DDE5BE10FD7f](https://sepolia.etherscan.io/address/0xB4047FD588b8477491A571Bd2522DDE5BE10FD7f)

---

## 1. El Problema y La Solución (Pitch)

* **El Problema:** La interacción de los hinchas en internet es efímera y está controlada por corporaciones. Los foros se borran y los fanáticos no son verdaderos dueños de su huella digital. A su vez, la barrera de entrada a Web3 es demasiado alta: obligar a un hincha común a crear una wallet (MetaMask), guardar frases semilla y comprar criptomonedas para pagar el gas es un fracaso de UX garantizado.
* **La Solución:** Un "Mural Digital" descentralizado al que los usuarios acceden a través de la aplicación que ya usan todos los días: **Telegram**.
* **La Magia (Account Abstraction):** El usuario envía un comando en Telegram (`/gritar`). El sistema aprueba el contenido mediante moderación, y nuestra **Server Wallet** (vía Thirdweb) patrocina el gas. El hincha graba su mensaje en la blockchain para siempre sin fricción alguna.

---

## 2. Brainstorming y Evolución del Proyecto

El proyecto nació de la necesidad de fusionar tecnología Web3 de vanguardia con la pasión popular del fútbol uruguayo. 
1. **Idea inicial:** Una web tradicional donde la gente conecte MetaMask. *(Descartada: demasiada fricción para el usuario Web2 promedio).*
2. **Pivot:** Mover la interfaz a Telegram, una app masiva y accesible.
3. **El Desafío:** ¿Cómo interactúa la gente con la blockchain sin pagar gas?
4. **Solución definitiva:** Implementar un **Relayer/Server Wallet** (ERC-4337 conceptual) que subsidie las transacciones. Esto transformó la idea en un producto Web2.5 perfecto: interfaz tradicional y amigable + base de datos inmutable.

---

## 3. Business Model Canvas

* **Segmentos de Clientes:** Hinchas, comunidades deportivas, creadores de contenido y usuarios ajenos al ecosistema cripto que buscan dejar su huella.
* **Propuesta de Valor:** Registro inmutable de mensajes, adopción Web3 "Zero-Gas" (sin fricción), y seguridad anti-spam gracias a un sistema de moderación asíncrona.
* **Canales:** Grupos de Telegram de hinchas, redes sociales (X, Instagram), foros deportivos.
* **Relación con Clientes:** Automatizada mediante el bot de Telegram (Notificaciones en tiempo real del minado de su transacción a través de WebSockets).
* **Fuentes de Ingresos:** Actualmente es un *Public Good* (Bien Público). A futuro: cobro de micropagos (fiat o tokens) por mensajes destacados, o la opción de acuñar (mint) el recibo del mensaje como un NFT conmemorativo.
* **Actividades Clave:** Moderación de mensajes, mantenimiento del bot Node.js, fondeo de la Server Wallet.
* **Recursos Clave:** Smart Contract en Sepolia, Servidor Node.js (Render), API de Telegram, Infraestructura y SDK de Thirdweb.
* **Estructura de Costos:** Hosting del backend, tarifas de gas (ETH Sepolia) subsidiadas en la blockchain.

---

## 4. Modelo de Datos y Arquitectura Técnica

El proyecto cuenta con una arquitectura dividida en dos capas altamente seguras:

### Capa On-Chain (Solidity)
* **Contrato Lógico y Proxy:** Utiliza una arquitectura de Proxy (V4). La lógica reside en la función principal `dejarMensaje(string)`.
* **Seguridad y Control de Acceso:** Cuenta con modificadores que bloquean transacciones EOA directas maliciosas. Solo la Server Wallet autorizada (`0x65E17C...`) puede escribir en el contrato, garantizando que el 100% de los mensajes on-chain pasaron por moderación previa.
* **Eventos:** Emite `NuevoMensajeAvisado(address, string)` al confirmarse la transacción.

### Capa Off-Chain (Backend Node.js)
* **Telegram Bot API:** Interfaz cliente-servidor (Long Polling) que recibe solicitudes.
* **Sistema de Colas en Memoria:** Uso de estructuras `Map()` para gestionar solicitudes pendientes vinculadas a Chat IDs.
* **Tolerancia a fallos:** Implementación de reconexión automática y manejo de excepciones (`uncaughtException`) para caídas de WebSockets.
* **Ethers.js (WebSockets):** Conexión en vivo al RPC de Sepolia para escuchar eventos on-chain en tiempo real y notificar a los usuarios.
* **Thirdweb SDK:** Orquestador de transacciones (Relayer) para pagar el gas de forma programática.

---

## 5. Diseño y Wireframes (Flujo de Usuario)

A continuación, el flujo real de la aplicación desde la perspectiva del usuario y del moderador:

1. **Usuario interactuando:** 
![Usuario pidiendo escribir en el mural](link_a_tu_imagen_1.jpg)

2. **Panel del Moderador:** 
![Moderador aprobando el mensaje](link_a_tu_imagen_2.jpg)

3. **Confirmación en Blockchain:** 
![Transacción exitosa en Etherscan](link_a_tu_imagen_3.jpg)

---
*Built with 💻 and 🧉 for Ethereum Uruguay 2026.*
