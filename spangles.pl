% Titulo: SPANGLES
% Autor: Vitor & Eduardo
% Data: 15-10-2009


%LIBRARIAS

:-use_module(library(lists)).
:-use_module(library(random)).


% ---------------------------------------------------------------------------
% REPRESENTACAO DO ESTADO

%estados: 0-00, 1-1B, 2-1C, 3-2B, 4-2C

%estado_inicial(-Tabuleiro).
estado_inicial(
        [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
        [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]).


% ---------------------------------------------------------------------------
% PREDICADOS CENTRAIS DO JOGO

%inicio.
%Predicado que corre o jogo.
inicio:-
        apresentacao,
        tipo_jogo(Tipo, Jog1, Jog2),
        estado_inicial(Tabuleiro),
        visualiza_tabuleiro(Tabuleiro),
        joga(Jog1, Jog2, Tabuleiro, Tipo),
        final.

apresentacao:-
              nl, write('---Spangles em Prolog---'),
              nl, write('---Versao 1.0---'), nl.

%tipo_jogo(-Tipo, -Jog1, -Jog2).
%Este predicado devolve o nome do primeiro e segundo jogador (Computador ou Humano)
%assim como o tipo de jogo (1,2,3,4).
tipo_jogo(Tipo, Jog1, Jog2):-
                write('1- Humano-Computador, 2-Computador-Humano, 3-Humano-Humano, 4-Computador-Computador'), nl,
                repeat,
                get_code(Tipo), Tipo>=49, Tipo=<52,
                tipo_de_jogo(Tipo,Jog1,Jog2).

%tipo_de_jogo(+Tipo, -Jog1, -Jog2).
tipo_de_jogo(49,'Humano','Computador').
tipo_de_jogo(50,'Computador','Humano').
tipo_de_jogo(51,'Humano','Humano').
tipo_de_jogo(52,'Computador','Computador').

final:-
       nl, write('Fim'), nl.


% ---------------------------------------------------------------------------
% JOGADAS - TIPOS

%joga(+Jogador1, +Jogador2, +Tabuleiro, +Tipo de Jogo).
%Recebe os nomes dos jogadores, o tabuleiro inicial e o tipo de jogo.
%Contem a primeira jogada que difere das jogadas seguintes por conter apenas
%uma orientacao. Para cada jogada é testado se joga o Humano ou Computador.
joga(Jog1, Jog2, Tabuleiro, Tipo):-
           write(Jog1), nl,
           (Jog1='Humano' ->
           (get_orientacao(Orientacao));
           (gera_orientacao(Orientacao))),
           primeira_jogada(Orientacao, Tabuleiro, TabNovo),
           visualiza_tabuleiro(TabNovo),
           jogada_seguinte(Jog2, 2, 49, TabNovo, Tipo).

%primeira_jogada(+Orientacao, +Tabuleiro, -TabNovo).
%Dada uma orientacao e um tabuleiro, devolve um tabuleiro novo com a jogada.
primeira_jogada(Orientacao, Tabuleiro, TabNovo):-
                            (Orientacao=98 -> Estado=1 ; Estado=3),
                            escreve_tabuleiro(13, 13, Estado, Tabuleiro, TabNovo).
                         
%jogada_seguinte(+Jogador, +Numero do Jogador, +Numero de jogadas, +Tabuleiro, +Tipo).
%O predicado repete-se ate chegar a uma condicao de fim (Empate ou Ganho).
%O empate acontece quando as pecas acabam (50 pecas no total),
%por isso este predicado recebe o nome e numero do jogador actual e
%o numero de pecas/jogadas que faltam para o jogo acabar, que vai sendo decrementado,
%assim como o tabuleiro de jogo e o tipo.
jogada_seguinte(Jogador, NJog, Numero, Tabuleiro, Tipo):-
                         nl, write(Jogador), nl,
                         (Jogador='Humano' ->
                         (pede_jogada(NJog, Linha, Coluna, Estado, Tabuleiro));
                         (calcula_jogada(NJog, Linha, Coluna, Estado, Tabuleiro))),
                         write('Linha: '), write(Linha), nl,
                         write('Coluna: '), write(Coluna), nl,
                         write('Estado: '), write(Estado), nl,
                         (Estado>0 ->
                         (escreve_tabuleiro(Linha, Coluna, Estado, Tabuleiro, TabNovo),
                         visualiza_tabuleiro(TabNovo),
                         troca_jogador(NJog, NJ),
                         muda_jogador(Tipo, Jogador, JogNovo),
                         N1 is Numero-1,
                         verifica_victoria(Jogador,Estado,Linha,Coluna,Tabuleiro,Ganha),
                         (Ganha = ganhou -> write('Jogador acutal ganha');
                         (Ganha = continua -> jogada_seguinte(JogNovo, NJ, N1, TabNovo, Tipo);
                         (Ganha = ganhaoutro -> write('Jogador anterior ganha')))));
                         (write('Invalido'),
                         jogada_seguinte(Jogador, NJog, Numero, Tabuleiro, Tipo))).
                         
jogada_seguinte(_, _, 0, _, _):-
                   write('Empate'), nl.
                            
%muda_jogador(+Tipo, +Jogador, -Novo Jogador).
%De acordo com o tipo de jogo e o jogador actual e alternado o jogador
muda_jogador(49,'Humano','Computador').
muda_jogador(49,'Computador','Humano').
muda_jogador(50,'Humano','Computador').
muda_jogador(50,'Computador','Humano').
muda_jogador(51,'Humano','Humano').
muda_jogador(52,'Computador','Computador').

%troca_jogador(+NJ Input, -NJ Output).
troca_jogador(1, 2).
troca_jogador(2, 1).

% ---------------------------------------------------------------------------
% PREDICADOS PARA HUMANO E COMPUTADOR

%get_orientacao(-Orientacao) -> Humano.
%Obtem a orientacao da primeira peca (cima ou baixo - 'c' ou 'b').
get_orientacao(Orientacao):-
                            write('Insira Orientacao: '), nl,
                            repeat, get_code(Orientacao),
                            (Orientacao>=98, Orientacao=<99), !.

%gera_orientacao(-Orientacao) -> Computador.
%Gera a orientacao da primeira peca.
gera_orientacao(Orientacao):-
                             Rand is random(1),
                             (Rand=0 -> Orientacao=98 ; Orientacao=99).

%pede_jogada(+Jogador, -Linha, -Coluna, -Estado, +Tabuleiro) -> Humano.
%Dado o numero do jogador e o tabuleiro
%e devolvida a linha, coluna e o estado correspondente.
pede_jogada(Jogador, Linha, Coluna, Estado, Tabuleiro):-
                     get_jogada(Linha, Coluna),
                     validacao(Jogador, Linha, Coluna, Tabuleiro, Estado).

get_jogada(Linha, Coluna):-
                  get_linha(Linha),
                  get_coluna(Coluna).

get_linha(Linha):-
                  repeat,
                  write('Insira Linha'), nl,
                  read(Linha), Linha>0, Linha<26, !.

get_coluna(Coluna):-
                    repeat,
                    write('Insira Coluna'), nl,
                    read(Coluna), Coluna>0, Coluna<26, !.
                 
%calcula_jogada(+Jogador, -Linha, -Coluna, -Estado, +Tabuleiro) -> Computador.
%Dado o numero do jogador e o tabuleiro
%e calculada a linha, coluna e o estado correspondente.
calcula_jogada(Jogador, Linha, Coluna, Estado, Tabuleiro):-
                        avalia_jogo(Linini, Colini, Linfim, Colfim, Tabuleiro),
                        write(Linini), nl,
                        write(Linfim), nl,
                        write(Colini), nl,
                        write(Colfim), nl,
                        Linha is random(Linfim-Linini) + Linini,
                        Coluna is random(Colfim-Colini) + Colini,
                        validacao(Jogador, Linha, Coluna, Tabuleiro, Estado).

                 
% ---------------------------------------------------------------------------
% ESCRITA EM LISTAS - ESCREVE NO TABULEIRO

%escreve_tabuleiro(+Linha, +Coluna, +Estado, +Tabuleiro, -TabNovo).
%Dada uma linha, coluna, o estado para escrever e o tabuleiro
%que vai ser escrito, e devolvido um tabuleiro novo.
%O processo e dividido em varios predicados que consiste em primeiro isolar
%o elemento da linha, ou seja, uma lista, dado que um tabuleiro e uma
%lista de listas, seguido de isolar o elemento coluna, ou seja o elemento
%dessa lista que e um estado e substitui-lo pelo novo valor.
escreve_tabuleiro(Linha, Coluna, Estado, Tabuleiro, TabNovo):-
                         escreve_tabuleiro_aux(Linha, Coluna, Estado, Tabuleiro, Lista),
                         remove_at(X, Tabuleiro, Linha, TempTab),
                         insert_at(Lista, TempTab, Linha, TabNovo).

%escreve_tabuleiro_aux(+Linha, +Coluna, +Estado, +Tabuleiro, -Lista).
escreve_tabuleiro_aux(1, Coluna, Estado, [Cabeca|Resto], Lista):-
                         remove_at(X, Cabeca, Coluna, TempLista),
                         insert_at(Estado, TempLista, Coluna, Lista).
                     
escreve_tabuleiro_aux(Linha, Coluna, Estado, [Cabeca|Resto], Lista):-
                             Linha > 1,
                             Linha1 is Linha-1,
                             escreve_tabuleiro_aux(Linha1, Coluna, Estado, Resto, Lista).

%remove_at(-elemento_removido, +lista, +posicao, -lista_resultante).
remove_at(X,[X|Xs],1,Xs).
remove_at(X,[Y|Xs],K,[Y|Ys]):-
                              K > 1, K1 is K - 1,
                              remove_at(X,Xs,K1,Ys).

%insert_at(+elemento, +lista, +posicao, -lista_resultante).
insert_at(X,L,K,R):-
                    remove_at(X,R,K,L).
                    
%element_at(-elemento, +lista, +posicao).
element_at(X,[X|_],1).
element_at(X,[_|L],K):-
                       K > 1, K1 is K - 1,
                       element_at(X,L,K1).


% ---------------------------------------------------------------------------
% ESTADOS E ORIENTACAO

%testes de validacao retornam o estado que deve ser inserido caso seja possivel
%inserir uma peça no local pretendido ou o estado 0 se impossivel

%validacao(+Jogador,+Linha,+Coluna,+Tabuleiro,-Estado)
validacao(Jogador,Linha,Coluna,Tabuleiro,Estado):-
        verifica_vazio(Linha,Coluna,Tabuleiro,Veracidade),
        write(Veracidade),nl,
        (Veracidade=vazio ->
        verifica_lado_esq(Linha,Coluna,Tabuleiro,Orientacao) ; Estado=0),
        (Jogador=1 -> get_estado_j1(Orientacao,Estado);
        get_estado_j2(Orientacao,Estado)).


%verifica_vazio(+Linha,+Coluna,+Tabulerio,-Veracidade)
verifica_vazio(Linha,Coluna,Tabuleiro,Veracidade):-
        get_peca(Linha,Coluna,Tabuleiro,X),
        (X = 0 -> Veracidade=vazio ; Veracidade=cheio).


%verifica_lado(+Linha,+Coluna,+Tabuleiro,-Orientacao)
verifica_lado_esq(Linha,1,Tabuleiro,Orientacao):-
        verifica_lado_dir(Linha,1,Tabuleiro,Orientacao).


verifica_lado_esq(Linha,Coluna,Tabuleiro,Orientacao):-
        Coluna>1,
        Coluna1 is Coluna - 1,
        get_peca(Linha,Coluna1,Tabuleiro,X),
        (X=0->verifica_lado_dir(Linha,Coluna,Tabuleiro,Orientacao);
        (X>2->Orientacao=baixo;Orientacao=cima)).

verifica_lado_dir(Linha,25,Tabuleiro,Orientacao):-
        verifica_lado_cima(Linha,25,Tabuleiro,Orientacao).

verifica_lado_dir(Linha,Coluna,Tabuleiro,Orientacao):-
        Coluna<25,
        Coluna1 is Coluna + 1,
        get_peca(Linha,Coluna1,Tabuleiro,X),
        (X=0->verifica_lado_cima(Linha,Coluna,Tabuleiro,Orientacao);
        (X>2->Orientacao=baixo;Orientacao=cima)).

verifica_lado_cima(1,Coluna,Tabuleiro,Orientacao):-
        verifica_lado_baixo(1,Coluna,Tabuleiro,Orientacao).

verifica_lado_cima(Linha,Coluna,Tabuleiro,Orientacao):-
        Linha>1,
        Linha1 is Linha - 1,
        get_peca(Linha1,Coluna,Tabuleiro,X),
        (X=0->verifica_lado_baixo(Linha,Coluna,Tabuleiro,Orientacao);
        (X>2->Orientacao=baixo;Orientacao=0)).

verifica_lado_baixo(25,Coluna,Tabuleiro,Orientacao):-
        Orientacao=0.

verifica_lado_baixo(Linha,Coluna,Tabuleiro,Orientacao):-
        Linha<25,
        Linha1 is Linha + 1,
        get_peca(Linha1,Coluna,Tabuleiro,X),
        (X=0->Orientacao=0;(X=1->Orientacao=cima;
        (X=2->Orientacao=cima;Orientacao=0))).


%obtencao do estado a inserir no tabuleiro tendo em
%conta qual o jogador e a orientacao da peça a inserir.

%get_estado_j1(+Orientacao,-Estado)
get_estado_j1(Orientacao,Estado):-
        write('jog1'),nl,write(Orientacao),nl,
        (Orientacao=baixo -> Estado=1;
        (Orientacao=cima -> Estado=3; Estado=0 )).

%get_estado_j2(+Orientacao,-Estado)
get_estado_j2(Orientacao,Estado):-
        (Orientacao=baixo -> Estado=2;
        (Orientacao=cima -> Estado=4; Estado=0 )).

get_peca(1,Coluna,[Cabeca|Cauda],Peca):-
        %write(Cabeca),
        element_at(Peca,Cabeca,Coluna).
        %write(Peca).

get_peca(Linha,Coluna,[Cabeca|Cauda],Peca):-
        Linha>1,
        Linha1 is Linha - 1,
        %write(Cauda),
        get_peca(Linha1,Coluna,Cauda,Peca).
        

% ---------------------------------------------------------------------------
% AVALIACAO DO JOGO

%avalia_jogo(-Linha inicial, -Coluna inicial, -Linha fim, -Coluna fim, +Tabuleiro).
%Dado um tabuleiro e devolvido o espaco do jogo onde se encontram pecas
avalia_jogo(Linini, Colini, Linfim, Colfim, Tabuleiro):-
                    %Colini is 10, Colfim is 16,
                    encontra_linhas(Tabuleiro, Linini, Linfim, 1),
                    encontra_colunas(Tabuleiro, Colini, Colfim, 1).

encontra_linhas([Cabeca | Resto], Linini, Linfim, N):-
                        N1 is N+1,
                        N2 is N-1,
                        ((member(1, Cabeca);
                        member(2, Cabeca);
                        member(3, Cabeca);
                        member(4, Cabeca)) ->
                        (Linini = N2, encontra_linfim(Resto, Linfim, N1));
                        (encontra_linhas(Resto, Linini, Linfim, N1))).

encontra_linfim([Cabeca | Resto], Linfim, N):-
                        N1 is N+1,
                        ((member(1, Cabeca);
                        member(2, Cabeca);
                        member(3, Cabeca);
                        member(4, Cabeca)) ->
                        encontra_linfim(Resto, Linfim, N1);
                        Linfim = N).

encontra_colunas(Tabuleiro, Colini, Colfim, 1):-
                            get_coluna(1,1,Tabuleiro,Colini),
                            get_coluna_2(1,1,Tabuleiro,Col,1),
                            (Col < 25 -> Colfim is Col +1).

get_coluna(Linha,Coluna,Tabuleiro,Colunac):-
        Linha <26,
        Linha1 is Linha + 1,
        get_peca(Linha,Coluna,Tabuleiro,Peca),
        (Peca>0 -> (Coluna=1 -> Colunac=Coluna; Colunac is Coluna-1);
        get_coluna(Linha1,Coluna,Tabuleiro,Colunac)).

get_coluna(Linha,Coluna,Tabuleiro,Colunac):-
        Linha  = 26,
        Linha1 is 1,
        Coluna1 is Coluna+1,
        get_coluna(Linha1,Coluna1,Tabuleiro,Colunac).
        
get_coluna_2(Linha,Coluna,Tabuleiro,Colunac,N):-
        %write(Linha),write(Coluna),nl,
        Linha <26,
        Linha1 is Linha + 1,
        N1 is Coluna,
        get_peca(Linha,Coluna,Tabuleiro,Peca),
        ((Peca>0,N1>N) -> get_coluna_2(Linha1,Coluna,Tabuleiro,Colunac,N1);
        get_coluna_2(Linha1,Coluna,Tabuleiro,Colunac,N)).


get_coluna_2(Linha,Coluna,Tabuleiro,Colunac,N):-
        %write('Mudou Coluna'),nl,
        Linha  = 26,
        Linha1 is 1,
        Coluna1 is Coluna+1,
        %write('coluna= '),
        %write(Coluna1),nl,
        (Coluna1 > 25 ->  Colunac is N ; get_coluna_2(Linha1,Coluna1,Tabuleiro,Colunac,N)).
                        

%verifica_victoria(+Jogador,+Estado,+Linha,+Coluna,+Tabuleiro,-Ganha)
%predicado que depois de uma jogada vai verificar se algum dos jogadores ganhou
%devolve Ganha=ganhou em caso do jogador que tenha jogado a última peça tenha alcançado a vitória
%devolve Ganha=ganhououtro em caso do jogador que jogou anteriormente tenha alcançado a vitória com uma jogada do seu oponente
%devolve Ganha=continua em caso de ainda não estarem reunidas as condições para a vitória de um dos jogadores
verifica_victoria(Jogador,Estado,Linha,Coluna,Tabuleiro,Ganha):-
        (Jogador=1 -> victoria_jog1(Estado,Linha,Coluna,Tabuleiro,Ganha);
        victoria_jog2(Estado,Linha,Coluna,Tabuleiro,Ganha)).

%victoria_jog1(+Estado,+Linha,+Coluna,+Tabuleiro,-Ganha)
%Verificação de vitória do jogador 1
victoria_jog1(Estado,Linha,Coluna,Tabuleiro,Ganha):-
        (Estado>2 -> tri_baixo(Estado,Linha,Coluna,Tabuleiro,Ganha);
        tri_cima_b(Estado,Linha,Coluna,Tabuleiro,Ganha)).

%victoria_jog2(+Estado,+Linha,+Coluna,+Tabuleiro,-Ganha)
%Verificação de vitória do jogador 2
victoria_jog2(Estado,Linha,Coluna,Tabuleiro,Ganha):-
        (Estado>2 -> tri_baixo(Estado,Linha,Coluna,Tabuleiro,Ganha);
        tri_cima_b(Estado,Linha,Coluna,Tabuleiro,Ganha)).


%VERIFICAÇAO DE VITÓRIA QUANDO UMA PEÇA É INSERIDA PARA CIMA

%tri_baixo(+Estado,+Linha,+Coluna,+Tabuleiro,-Ganha)
%verificação de vitória quando a nova peça é inserida para cima
%preenchendo o centro estando o triangulo grande para baixo
%%@£@     £-> peça sobre a qual se faz a verificação
%% @      @-> outras peças que vão formar o triangulo grande
tri_baixo(Estado,Linha,1,Tabuleiro,Ganha):-
        tri_dir(Estado,Linha,1,Tabuleiro,Ganha).

tri_baixo(Estado,Linha,25,Tabuleiro,Ganha):-
        tri_dir(Estado,Linha,25,Tabuleiro,Ganha).

tri_baixo(Estado,25,Coluna,Tabuleiro,Ganha):-
        tri_dir(Estado,25,Coluna,Tabuleiro,Ganha).

tri_baixo(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna-1,
         Coluna2 is Coluna+1,
         Linha1 is Linha+1,
         get_peca(Linha,Coluna1,Tabuleiro,Peca1),
         get_peca(Linha,Coluna2,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
         Estado1 is Estado-Peca1,
         ((Peca1>0,Peca1=Peca2,Peca2=Peca3)->(Estado1=2 ->
         Ganha=ganhou; Ganha=ganhououtro );
         tri_dir(Estado,Linha,Coluna,Tabuleiro,Ganha)).

%tri_esq(+Estado,+Linha,+Coluna,+Tabuleiro,-Ganha)
%verificação de vitória quando a nova peça é inserida para cima
%preenchendo o canto inferior direito estando o triangulo grande para cima
%% @    £-> peça sobre a qual se faz a verificação
%%@@£   @-> outras peças que vão formar o triangulo grande
tri_esq(Estado,Linha,1,Tabuleiro,Ganha):-
        Ganha=continua.

tri_esq(Estado,1,Coluna,Tabuleiro,Ganha):-
        tri_cima(Estado,1,Coluna,Tabuleiro,Ganha).

tri_esq(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna-1,
         Coluna2 is Coluna-2,
         Linha1 is Linha-1,
         get_peca(Linha,Coluna1,Tabuleiro,Peca1),
         get_peca(Linha,Coluna2,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna1,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
        (Peca1=0->tri_cima(Estado,Linha,Coluna,Tabuleiro,Ganha);
        ((Estado=Peca2,Peca2=Peca3)->Ganha=ganhou;tri_cima(Estado,Linha,Coluna,Tabuleiro,Ganha))).

%tri_dir(+Estado,+Linha,+Coluna,+Tabuleiro,-Ganha)
%verificação de vitória quando a nova peça é inserida para cima
%preenchendo o canto inferior esquerdo estando o triangulo grande para cima
%% @    £-> peça sobre a qual se faz a verificação
%%£@@   @-> outras peças que vão formar o triangulo grande
tri_dir(Estado,Linha,25,Tabuleiro,Ganha):-
        tri_esq(Estado,Linha,25,Tabuleiro,Ganha).

tri_dir(Estado,1,Coluna,Tabuleiro,Ganha):-
        tri_cima(Estado,1,Coluna,Tabuleiro,Ganha).

tri_dir(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna+1,
         Coluna2 is Coluna+2,
         Linha1 is Linha-1,
         get_peca(Linha,Coluna1,Tabuleiro,Peca1),
         get_peca(Linha,Coluna2,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna1,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
        (Peca1=0 -> tri_esq(Estado,Linha,Coluna,Tabuleiro,Ganha) ;
        ((Estado=Peca2,Peca2=Peca3)->Ganha=ganhou;
        tri_esq(Estado,Linha,Coluna,Tabuleiro,Ganha))).


%tri_cima(+Estado,+Linha,+Coluna,+Tabuleiro,-Ganha)
%verificação de vitória quando a nova peça é inserida para cima
%preenchendo o canto superior estando o triangulo grande para cima
%% £    £-> peça sobre a qual se faz a verificação
%%@@@   @-> outras peças que vão formar o triangulo grande
tri_cima(Estado,25,Coluna,Tabuleiro,Ganha):-
        Ganha=continua.

tri_cima(Estado,Linha,1,Tabuleiro,Ganha):-
        Ganha=continua.

tri_cima(Estado,Linha,25,Tabuleiro,Ganha):-
        Ganha=continua.

tri_cima(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna-1,
         Coluna2 is Coluna+1,
         Linha1 is Linha+1,
         get_peca(Linha1,Coluna,Tabuleiro,Peca1),
         get_peca(Linha1,Coluna1,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna2,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
        (Peca1=0-> Ganha=continua ;
        ((Estado=Peca2,Peca2=Peca3)->Ganha=ganhou; Ganha=continua)).


%VERIFICAÇAO DE VITÓRIA QUANDO UMA PEÇA É INSERIDA PARA BAIXO

tri_baixo_b(Estado,Linha,1,Tabuleiro,Ganha):-
        Ganha=continua.

tri_baixo_b(Estado,Linha,25,Tabuleiro,Ganha):-
        Ganha=continua.

tri_baixo_b(Estado,1,Coluna,Tabuleiro,Ganha):-
        Ganha=continua.

tri_baixo_b(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna-1,
         Coluna2 is Coluna+1,
         Linha1 is Linha-1,
         get_peca(Linha1,Coluna1,Tabuleiro,Peca1),
         get_peca(Linha1,Coluna,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna2,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
        (Peca2=0-> Ganha=continua ;
        ((Estado=Peca1,Peca1=Peca3)->Ganha=ganhou; Ganha=continua)).

tri_esq_b(Estado,Linha,1,Tabuleiro,Ganha):-
        Ganha=continua.

tri_esq_b(Estado,1,Coluna,Tabuleiro,Ganha):-
        tri_cima_b(Estado,1,Coluna,Tabuleiro,Ganha).

tri_esq_b(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna-1,
         Coluna2 is Coluna-2,
         Linha1 is Linha+1,
         get_peca(Linha,Coluna1,Tabuleiro,Peca1),
         get_peca(Linha,Coluna2,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna1,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
        (Peca1=0->tri_baixo_b(Estado,Linha,Coluna,Tabuleiro,Ganha);
        ((Estado=Peca2,Peca2=Peca3)->Ganha=ganhou;
        tri_baixo_b(Estado,Linha,Coluna,Tabuleiro,Ganha))).

tri_dir_b(Estado,Linha,25,Tabuleiro,Ganha):-
        tri_esq_b(Estado,Linha,25,Tabuleiro,Ganha).

tri_dir_b(Estado,1,Coluna,Tabuleiro,Ganha):-
        tri_cima_b(Estado,1,Coluna,Tabuleiro,Ganha).

tri_dir_b(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna+1,
         Coluna2 is Coluna+2,
         Linha1 is Linha+1,
         get_peca(Linha,Coluna1,Tabuleiro,Peca1),
         get_peca(Linha,Coluna2,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna1,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
        (Peca1=0-> tri_esq_b(Estado,Linha,Coluna,Tabuleiro,Ganha);
        ((Estado=Peca2,Peca2=Peca3)->Ganha=ganhou;
        tri_esq_b(Estado,Linha,Coluna,Tabuleiro,Ganha))).

tri_cima_b(Estado,1,Coluna,Tabuleiro,Ganha):-
        tri_dir_b(Estado,1,Coluna,Tabuleiro,Ganha).

tri_cima_b(Estado,Linha,1,Tabuleiro,Ganha):-
        tri_dir_b(Estado,Linha,1,Tabuleiro,Ganha).

tri_cima_b(Estado,Linha,25,Tabuleiro,Ganha):-
        tri_esq_b(Estado,Linha,25,Tabuleiro,Ganha).

tri_cima_b(Estado,Linha,Coluna,Tabuleiro,Ganha):-
         Coluna1 is Coluna-1,
         Coluna2 is Coluna+1,
         Linha1 is Linha-1,
         get_peca(Linha,Coluna1,Tabuleiro,Peca1),
         get_peca(Linha,Coluna2,Tabuleiro,Peca2),
         get_peca(Linha1,Coluna,Tabuleiro,Peca3),
         write(Peca1),write(Peca2),write(Peca3),nl,
         Estado1 is Estado-Peca1,
         ((Peca1>0,Peca1=Peca2,Peca2=Peca3)->((Estado1=2;Estado1=(-2)) ->
         Ganha=ganhou; Ganha=ganhououtro );
         tri_dir_b(Estado,Linha,Coluna,Tabuleiro,Ganha)).
         
% ---------------------------------------------------------------------------
% VISUALIZACAO DO ESTADO DO JOGO - MODO DE TEXTO

%visualiza_tabuleiro(+Tabuleiro)
%Dado um Tabuleiro em forma de uma lista de listas,
%este e convertido para modo de texto.
%O predicado consiste em varias fases.
%Primeiro isolam-se as listas e depois o seu conteudo
%(que sao estados) que sao impressos no ecra.
visualiza_tabuleiro(Tabuleiro):-
                                nl, write('    01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25'), nl,
                                mostra_linhas(1,Tabuleiro),
                                write('    01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25'), nl, nl, !.

%mostra_linhas(+Numero da linha, +Linha)
mostra_linhas(_,[]).
mostra_linhas(N,[Linha|Resto]):-
                                N<10, write('0'), write(N), write(' '), mostra_linha(Linha), write('| 0'), write(N), nl,
                                N2 is N+1,
                                mostra_linhas(N2, Resto).
mostra_linhas(N,[Linha|Resto]):-
                                N>9, write(N), write(' '), mostra_linha(Linha), write('| '), write(N), nl,
                                N2 is N+1,
                                mostra_linhas(N2, Resto).

%mostra_linha(+Linha)
mostra_linha([]).
mostra_linha([Cabeca|Resto]):-
                              write('|'), escreve(Cabeca),
                              mostra_linha(Resto).

%escreve(+estado)
escreve(0):-
            write('00').
escreve(1):-
            write('1b').
escreve(3):-
            write('1c').
escreve(2):-
            write('2b').
escreve(4):-
            write('2c').


% ---------------------------------------------------------------------------
% OUTROS - PREDICADOS DE VERSOES ANTERIORES (NAO USADOS)

%por-fazer(+Variavel).
%Predicado TODO
por_fazer(Variavel):-
                     nl, write('Por Fazer '), write(Variavel), nl.

%Pede linha e coluna (Versao 1 - nao usado).
%get_linha(Linha):-
%                  write('Insira Linha: '), nl,
%                  get_code(Lin),
%                  converte(Lin, Linha).

%get_coluna(Coluna):-
%                    write('Insira Coluna: '), nl,
%                    get_code(Col),
%                    converte(Col, Coluna).

%converte(+Input, -Output).
%Dado um input este e convertido num output de valor 1 a 25 (Linha ou Coluna).
%converte(Input, Output):- maiuscula(Input), Output is Input-64.
%converte(Input, Output):- minuscula(Input), Output is Input-96.
%converte(Input, Output):- numero(Input), Output is Input-48.

%maiuscula(Valor):- Valor>=65, Valor=<90.
%minuscula(Valor):- Valor>=97, Valor=<122.
%numero(Valor):- Valor>=49, Valor=<57.

%Pede linha e coluna (Versao 2 - nao usado).
%get_linha(Linha):-
%                  get_linha1(Lin1),
%                  get_linha2(Lin2),
%                  line(Lin1, Lin2, Linha).

%get_linha1(Lin1):-
%                  repeat,
%                  write('aqui'), nl,
%                  get_code(Lin1),
%                  write(Lin1), nl,
%                  (Lin1>=48, Lin1=<50).

%get_linha2(Lin2):-
%                  repeat,
%                  write('acola'), nl,
%                  get_code(Lin2),
%                  write(Lin2), nl,
%                  (Lin2>=48, Lin2=<57).

%get_coluna(Coluna):-
%                    get_coluna1(Col1),
%                    Coluna is Col1 - 96.

%get_coluna1(Col1):-
%                   repeat,
%                   get_code(Col1),
%                   (Col1>=97, Col1=<122).

%line(+Lin1, +Lin2, -Linha).
%Transforma o Lin1 e Lin2 em valores de 1 a 25 (Linha).
%line(48, Lin2, Linha):-
%         Linha is Lin2-48.
%line(48, 48, Linha):-
%         Linha is 1.
%line(49, Lin2, Linha):-
%         Linha is Lin2-38.
%line(50, Lin2, Linha):-
%         (Lin2 > 53 ->
%         (Linha is 25);
%         (Linha is Lin2-28)).

%Pede linha e coluna (Versao 3 - nao usado).
%get_jogada
%get_jogada(Linha, Coluna):-
%                  write('Insira Linha: '), nl,
%                  get_linha(Linha),
%                  write('Insira Coluna: '), nl,
%                  get_coluna(Coluna),
%                  Linha is Linha-96,
%                  Coluna is Coluna-96.

%get_linha e get_coluna devolvem a linha e a coluna
%no formato correcto para processamento.
%get_linha(Linha):-
%                  repeat,
%                  get_code(Linha),
%                  write(Linha),nl,
%                  Linha>=97, Linha=<122.

%get_coluna(Coluna):-
%                    repeat,
%                    get_code(Coluna),
%                    write(Coluna),nl,
%                    Coluna>=97, Coluna=<122.

%Pede linha e coluna (Versao 4 - nao usado).
%get_jogada(Linha, Coluna):-
%                  repeat,
%                  write('Insira Linha'), nl,
%                  read(Linha), Linha>0, Linha<26,
%                  write('Insira Coluna'), nl,
%                  read(Coluna), Coluna>0, Coluna<26.

%calcula_estado(+Jogador, +Linha, +Coluna, -Estado, +Tabuleiro) -
%(nao usado - o estado vai ser dado automaticamente pela orientacao).
%Recebe o numero do jogador, assim como a linha e coluna para poder calcular
%o estado que e o valor que vai ser escrito no tabuleiro.
%calcula_estado(Jogador, Linha, Coluna, Estado, Tabuleiro):-
%                        write('Estado'), nl.

%visualiza_tabuleiro(+Tabuleiro) - modo em letras (nao usado).
%visualiza_tabuleiro(Tabuleiro):-
%                                nl, write('    A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  X  Y  Z'), nl,
%                                mostra_linhas(1,Tabuleiro),
%                                write('    A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  X  Y  Z'), nl, nl, !.

%Tabuleiro de teste
%tabs([[0,0,0,0,0],
%      [0,0,3,0,0],
%      [0,4,1,0,0],
%      [0,0,0,0,0],
%      [0,0,0,0,0]]).

%fim(+Tabuleiro, -Bool, +Numero de vezes)
%Testa se ha vencedor percorrendo 3 listas de cada vez (Versao 1 - nao usado).
%fim([Cabeca1 | Resto], Bool, N):-
%             fim_aux1(Resto, Cabeca2, Cabeca3),
%             N1 is N-1,
%             testa3l(Cabeca1, Cabeca2, Cabeca3, 2, Bool),
%             (N > 0 ->
%             fim(Resto, Bool, N1)).

%Separador de cabecas (listas).
%fim_aux1([Cabeca | Resto], Cabeca2, Cabeca3):-
%                 Cabeca2 is Cabeca,
%                 fim_aux2(Resto, Cabeca3).

%fim_aux2([Cabeca | Resto], Cabeca3):-
%                 Cabeca3 is Cabeca.

%testa3l(+Lista1, +Lista2, +Lista3, +Posicao, -Bool).
%Dadas 3 listas e uma posicao (que tambem funciona como um contador)
%testa as varias condicoes de vitoria.
%testa3l(Lista1, Lista2, Lista3, Posn, Bool):-
%                Posm is Posicao-1,
%                Posp is Posicao+1,
%                element_at(Elemento1, Lista1, Posn),
%                element_at(Elemento2, Lista2, Posm),
%                element_at(Elemento3, Lista2, Posn),
%                element_at(Elemento4, Lista2, Posp),
%                element_at(Elemento5, Lista3, Posn),
%                (Elemento1=0-> Bool=0;
%                (Elemento2=Elemento4->
%                (Elemento1=Elemento2-> Bool=1;
%                (Elemento4=Elemento5-> Bool=1 ; Bool=0));
%                Bool=0)),
%                Pos is Posn+1,
%                (Bool = 0 -> (Pos < 25 ->
%                testa3l(Lista1, Lista2, Lista3, Pos, Bool))).

%encontra linhas e colunas (Versao 1 - nao usado).
%encontra_linhas([],_,_,_)
%encontra_linhas([Cabeca | Resto], Linini, Linfim, N):-
%                        a
%                        encontra_linini(Cabeca, Bool),
%                        N1 is N+1,
%                        N2 is N-1,
%                        (Bool = 1 ->
%                        ((Linini = N2), (encontra_linfim(Resto, Linfim, N)));
%                       (encontra_linhas(Resto, Linini, Linfim, N1))).

%encontra_linini([],_).
%encontra_linini([Cabeca | Resto], Bool):-
%                        write('aqui1'),nl,
%                        (Cabeca = 0 ->
%                        encontra_linini(Resto, Bool);
%                        Bool = 1).

%encontra_linfim([],_,_).
%encontra_linfim([Cabeca | Resto], Linfim, N):-
%                        write('aqui2'),nl,
%                        encontra_linfim_aux(Cabeca, Bool),
%                        N1 is N+1,
%                        (Bool = 0 ->
%                        encontra_linfim(Resto, Linfim, N1);
%                        Linfim = N1).

%encontra_linfim_aux([],_).
%encontra_linfim_aux([Cabeca | Resto], Bool):-
%                            (Cabeca = 0 ->
%                            encontra_linfim_aux(Resto, Bool);
%                            Bool=0).
                            
%encontra_colini([0 | Resto], Colini, Colfim, N, Temp, Temp2):-
%                   N1 is N+1,
%                   write('aqui'),nl,
%                   encontra_colini(Resto, Colini, Colfim, N1, Temp, Temp2).

%encontra_colini([_| Resto], Colini, Colfim, N, Temp, Temp2):-
%                    N1 is N+1,
%                    N2 is N-1,
%                    write('aqui2'),nl,
%                    write(N),nl,
%                    write(Temp),nl,
%                    (N<Temp -> (Colini=N2, Temp=N2, write(Colini), nl,
%                    encontra_colfim(Resto, Colfim, N1, Temp2)).

%encontra_colunas([Cabeca | Resto], Linini, Linfim, Colini, Colfim, N):-
%                         N1 is N+1,
%                         (Linini = N ->
%                         encontra_colinifim(Resto, Linfim, Colini, Colfim, N1, 25, 1);
%                         encontra_colunas(Resto, Linini, Linfim, Colini, Colfim, N1)).

%encontra_colinifim([Cabeca | Resto], Linfim, Colini, Colfim, N, Temp, Temp2):-
%                        N1 is N+1,
%                        write(Cabeca),nl,
%                        encontra_colini(Cabeca, Colini, Colfim, 1, Temp, Temp2),
%                        write(Colini),nl,
%                        (Linfim > N1 ->
%                        encontra_colinifim(Resto, Linfim, Colini, Colfim, N1, Temp, Temp2)).

%encontra_colini([Cabeca | Resto], Colini, Colfim, N, Temp, Temp2):-
%                    N1 is N+1,
%                    N2 is N-1,
%                    write(N),nl,
%                    write(Temp),nl,
%                    (Cabeca = 0 -> encontra_colini(Resto, Colini, Colfim, N1, Temp, Temp2);
%                    ((N < Temp ->
%                    (Colini=N2, Temp=N2,
%                    encontra_colfim(Resto, Colfim, N1, Temp2))))).

%encontra_colfim([],_,_,_).
%encontra_colfim([Cabeca | Resto], Colfim, N, Temp2):-
%                        write('eu'),nl,
%                        write(N),nl,
%                        N1 is N+1,
%                        ((Cabeca>0, N>Temp2) -> (Colfim=N1, Temp2=N1));
%                        encontra_colfim(Resto, Colfim, N1, Temp2).

%encontra_colunas(Tabuleiro, Colini, Colfim, N):-
%                         write('aqui'),nl,
%                         encontra_colunas_aux(Tabuleiro, Colini, Colfim, N, 1, Bool),
%                         N1 is N+1,
%                         %((Colini = 1; Colini = 2; Colini = 3; Colini = 4)->
%                         %write('encontrou');
%                         ((Bool = 0, N < 4) ->
%                         encontra_colunas(Tabuleiro, Colini, Colfim, N1)).

%encontra_colunas_aux([Cabeca | Resto], Colini, Colfim, N, V, Bool):-
%                         N1 is N-1,
%                         V1 is V+1,
%                         write(V),nl,
%                         element_at(Elemento, Cabeca, N),
%                         write(Elemento),nl,
%                         ((V < 4, Elemento = 0) -> (Bool=0,
%                         encontra_colunas_aux(Resto, Colini, Colfim, N, V1, Bool));
%                         (Colini=N1, Bool=1, write('lalala'))).

% ---------------------------------------------------------------------------
