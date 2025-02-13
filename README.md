Explicação dos Relacionamentos
Cliente (1) —— (N) Veiculo

Veiculo.idCliente é chave estrangeira para Cliente.idCliente.
Um cliente pode ter vários veículos.
Veiculo (1) —— (N) OrdemServico

OrdemServico.idVeiculo é chave estrangeira para Veiculo.idVeiculo.
Um veículo pode ter várias ordens de serviço ao longo do tempo.
Mecanico (1) —— (N) OrdemServico

OrdemServico.idMecanico é chave estrangeira para Mecanico.idMecanico.
Um mecânico pode ser responsável por várias ordens de serviço.
OrdemServico (1) —— (N) Pagamento

Pagamento.idOrdem é chave estrangeira para OrdemServico.idOrdem.
Uma ordem de serviço pode ter um ou mais pagamentos (dependendo do seu modelo; se quiser apenas um pagamento por ordem, seria 1:1).
     
     
     +-----------------+              +-----------------+
     |     CLIENTE     |              |     VEICULO     |
     |-----------------|              |-----------------|
     | *idCliente (PK) | 1        N   | *idVeiculo (PK) |
     | nome            | <----------> | idCliente (FK)  |
     | telefone        |              | marca           |
     | endereco        |              | modelo          |
     +-----------------+              | ano             |
                                      | tipoVeiculo     |
                                      | statusVeiculo   |
                                      +-----------------+

                              1
     +-----------------+    N  
     |    MECANICO     | <------> +-----------------+
     |-----------------|          |  ORDEMSERVICO   |
     | *idMecanico (PK)|          |-----------------|
     | nome            |          | *idOrdem (PK)   |
     | especialidade   |          | idVeiculo (FK)  |
     +-----------------+          | idMecanico (FK) |
                                  | tipoServico     |
                                  | dataEntrada     |
                                  | dataEntrega     |
                                  | tempoServico    |
                                  | status          |
                                  | observacoes     |
                                  +-----------------+
                                          |
                                          | 1
                                          N
                                  +-----------------+
                                  |   PAGAMENTO     |
                                  |-----------------|
                                  | *idPagamento(PK)|
                                  | idOrdem (FK)    |
                                  | valor           |
                                  | dataPagamento   |
                                  | tipoPagamento   |
                                  | statusPagamento |
                                  +-----------------+
