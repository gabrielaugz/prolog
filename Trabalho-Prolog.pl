:- consult('basedados.pl'). % carrega o arquivo com os dados

% oceano(X) X é um oceano
% pais(X) X é um país
% continente(X) X é um continente
% fronteira(X,Y) se X faz fronteira com Y, onde X são países ou oceanos e Y são países.
% loc(X,Y) se X está localizado em Y, onde X é país e Y é continente

% Resolução
% a) Quais são os países de um continente que fazem fronteira com oceanos?
escrever_resposta_a([]).
escrever_resposta_a([(Pais, Oceano)|Paises]) :- 
    loc(Pais, Continente),
    format('~w da ~w faz fronteira com o ~w', [Pais, Continente, Oceano]), nl,
    escrever_resposta_a(Paises).

alternativa_a(Paises) :- % a incógnita Paises é uma lista de pares (Pais, Oceano) 
    %%%%%%% sua implementacao aqui,
    Paises = [(Pais, Oceano) | []], 
    pais(Pais), oceano(Oceano), loc(Pais, Continente), fronteira(Oceano, Pais),
    escrever_resposta_a(Paises).


% b) Quais os oceanos que fazem limite com algum país de um continente, mas não com países de outro continente?
escrever_resposta_b([]).
escrever_resposta_b([(Oceano, Continente)|Oceanos]) :- 
    format('~w só faz limite com o continente ~w', [Oceano, Continente]), nl,
    escrever_resposta_b(Oceanos).

alternativa_b(Oceanos) :- % a incógnita Oceanos é uma lista de tuplas (Oceano, Continente)
    %%%%%%% sua implementacao aqui,
    Oceanos = [(Oceano, Continente) | []],
    oceano(Oceano), not(resposta(A, B, Oceano)),
    escrever_resposta_b(Oceanos).

resposta(A, B, Oceano) :- 
pais(A), pais(B), fronteira(Oceano, A), fronteira(Oceano, B), 
loc(A, C), loc(B, D), C \= D.


% c) Encontre todos os pares de países localizados em diferentes continentes que fazem fronteira com um mesmo oceano.
escrever_resposta_c([]).
escrever_resposta_c([(Pais1, Pais2, Oceano)|Paises]) :- 
    loc(Pais1, Continente1), loc(Pais2, Continente2),
    format('~w da ~w e ~w da ~w fazem fronteira com o ~w', [Pais1, Continente1, Pais2, Continente2, Oceano]), nl,
    escrever_resposta_c(Paises).

alternativa_c(Paises) :- % a incógnita Paises é uma lista de tuplas (Pais1, Pais2, Oceano)
    %%%%%%% sua implementacao aqui,
    Paises = [(Pais1, Pais2, Oceano) | []], 
    pais(Pais1), pais(Pais2), loc(Pais1, X), loc(Pais2, Y), X \= Y,
    fronteira(Oceano, Pais1), fronteira(Oceano, Pais2),
    escrever_resposta_c(Paises).


% d) Encontre todos os pares de países A e B, tais que:
%       i) A e B têm a mesma fronteira;
escrever_resposta_d_i([]).
escrever_resposta_d_i([(Pais1, Pais2, Pais3)|Paises]) :- 
    format('~w e ~w fazem fronteira com ~w', [Pais1, Pais2, Pais3]), nl,
    escrever_resposta_d_i(Paises).

alternativa_d_i(Paises) :- % a incógnita Paises é uma lista de tuplas (Pais1, Pais2, Pais3)
    %%%%%%% sua implementacao aqui,
    Paises = [(Pais1, Pais2, Pais3) | []],
    pais(Pais1), pais(Pais2), pais(Pais3),
    fronteira(Pais1, Pais3), fronteira(Pais2, Pais3), Pais1 \= Pais2, Pais2 \= Pais3, Pais3 \= Pais1,
    escrever_resposta_d_i(Paises).


%       ii) A e B são vizinhos, e A faz fronteira com um oceano e B não faz fronteira com um oceano;
escrever_resposta_d_ii([]).
escrever_resposta_d_ii([(Pais1, Pais2, Oceano)|Paises]) :- 
    format('~w faz fronteira com o ~w e ~w não faz fronteira com nenhum oceano', [Pais1, Oceano, Pais2]), nl,
    escrever_resposta_d_ii(Paises).

alternativa_d_ii(Paises) :- % a incógnita Paises é uma lista de tuplas (Pais1, Pais2, Oceano)
    %%%%%%% sua implementacao aqui,
    Paises = ([Pais1, Oceano, Pais2 | []]), 
    pais(Pais1), pais(Pais2), oceano(Oceano), fronteira(Oceano, Pais1), 
    fronteira(Pais2, Pais1), not(fronteira(Oceano, Pais2)), escrever_resposta_d_ii(Paises).
