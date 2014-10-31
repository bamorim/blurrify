# Blurrify

Serviço criado completamente inutil para demonstração no primeiro encontro hackergroup UFRJ.

## Soluções

Para cada tipo de solução, vou criar uma branch diferente. As soluções em negrito já tem branchs

* **Sidekiq**: Roda processos em background
* Celulloid: Roda tarefas em outra thread
* DCell: Roda tarefas em outras máquinas
* Celulloid + Faye: Roda tarefas em outra thread e usa o faye para mandar mensagens por websocket para o cliente
* ZMQP: Roda tarefas em outras máquinas usando um serviço de message queue

## On Going

Assim que eu tiver tempo eu continuo desenvolvendo ou deixo pra fazer algo usando isso num pŕoximo evento
