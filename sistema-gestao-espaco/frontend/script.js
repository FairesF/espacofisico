document.getElementById("formReserva").addEventListener("submit", async function (e) {
  e.preventDefault();
  const data = {
    idSolicitante: document.getElementById("idSolicitante").value,
    idEspaco: document.getElementById("idEspaco").value,
    dataReserva: document.getElementById("dataReserva").value,
    horaReserva: document.getElementById("horaReserva").value
  };

  const resposta = await fetch("http://localhost:8080/solicitacao", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  });
  const texto = await resposta.text();
  document.getElementById("respostaReserva").innerText = texto;
});

document.getElementById("formAvaliacao").addEventListener("submit", async function (e) {
  e.preventDefault();
  const data = {
    idSolicitacao: document.getElementById("idSolicitacao").value,
    idGestor: document.getElementById("idGestor").value,
    status: document.getElementById("status").value,
    justificativa: document.getElementById("justificativa").value
  };

  const resposta = await fetch("http://localhost:8080/avaliacao", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(data)
  });
  const texto = await resposta.text();
  document.getElementById("respostaAvaliacao").innerText = texto;
});