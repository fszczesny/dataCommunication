# DataCommunication
Trabalho final da disciplina INFO1005 - comunicação de dados - UFRGS 2019/2

**_1. Definição gerais_**

Modelar um sistema de comunicação de dados completo. Mais informações nos arquivos "informações_trabalho_2019.pdf" e "trabalho_final_2019.pdf", ambos contidos no repositorio.

**_2. Objetivos_**

* Avaliar um sistema completo em termos de bit errorrate (BER) e frame errorrate (FER), variando parâmetros do sistema
* Avaliação para um intervalo de Eb/N0.

**_3. Definição de modulação e código de canal_**

Conforme especificação dada ao grupo por meio de sorteio utilizaremos os seguintes parâmetros:

* Modulação: QPSK e 16QAM
* Código de Canal: Convolucional R={2/3 e 3/4}

**_4. Lista de itens a serem implementados_**

- [x] Fonte de informação aleatória
- [x] Codificador de canal convulacional com razões de 2/3 e 3/4
- [x] Moduladora 16QAM
- [x] Moduladora QPSK
- [x] Canal AWGN (Ruído branco genérico)
- [x] Demoduladora 16QAM
- [x] Demoduladora QPSK
- [x] Decodificador de canal convulacional com razões de 2/3 e 3/4
- [x] Receptor de informação
- [ ] Analisador de informação. Deve procesar a informação recebida e gerar os graficos esperados

**_5. Lista de itens a serem colocados no relatório_**

Documento de relatório e mais arquivos pertinentes encontram-se no link: https://drive.google.com/drive/folders/10F0sqENRUE73WlnKqqWJyDJ79DV5g_3q?usp=sharing

- [x] Criar documento no Google Drive
- [x] Colocar dados dos membros do grupo
- [x] Criar estrutura base do relatório
- [x] Descrever funcionalidades implementadas
- [ ] Descrever testes e simulações realizadas
- [ ] Expor resultados obtidos
