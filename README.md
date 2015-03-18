# Desafio Bronze (Obrigatório e tem que estar perfeito)

1) O código não está bem feito. Precisamos de 26 view controllers? Corrija o código;

2) Faça com que cada view mostre uma letra, uma palavra e uma imagem começada com a letra;

3) Crie uma animação ao mostrar as imagens em cada página.

4) Coloque um Tabbar que permita trocar entre: 

* Navegação no dicionário conforme já desenvolvido
* Table view mostrando todas as palavras do dicionário

5) Coloque um ToolBar em cada página de letra com a opção de editar; Na tela de edição o usuário pode mudar a palavra vinculada. Não é necessário persistir a alteração (via código e não via Xib).

6) Permita que o usuário possa selecionar a imagem e arrastá-la para qualquer posição da view. 

# Desafio Prata (Obrigatório)

1) Faça com que, ao tocar na imagem, haja uma animação da escala da foto, como se fosse um zoom. Enquanto o usuário estiver tocando na foto é dado zoom, quando ele parar de tocar, volta ao tamanho normal.

2) Continuando o item 5 do desafio bronze, permita que o usuário troque a imagem também e, além disso, persista os dados usando Realm.io

3) Permita que durante a edição da palavra e imagem que o usuário grave uma data usando o UIDatePicker

# Desafio Ouro (Opcional - Vale pontos para WWDC)

1) Crie uma tela inicial de busca no dicionario pela palavra; caso a palavra não exista no dicionário, é feita uma animação (como quando se digita a senha errada de desbloqueio no ios) e mostra uma mensagem; caso exista, é mostrada a view com a palavra buscada;

2) Permita que o usuário edite a foto que será adicionada na letra (prata 2) e, além disso, a imagem deve ser mostrada dentro de uma máscara redonda e não retangular que é a forma default.

3) Permita que o usuário use o gesto "Pinch" para dar zoom na foto (prata 1).
