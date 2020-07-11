# aula_19_flutter_exercicio
<h6>
Exercicio realizado em conjunto para praticar a interação dos alunos em unico projeto
</h6>
<h4>Exercicio proposto e fazer uma tela de cadastro</h4>


<h5>REQUISITOS MÍNIMOS</h4>
<h6>
Todos os campos devem ser preenchidos com algum valor.
Algumas regras adicionais aos campos:
<li>- nome : de 3 a 30 caracteres.
<li>- email:  tem que ter um email válido.</li>
<li>- utilize o pacote email_validator.</li>
<li>- cpf: tem que ser um cpf válido.</li>
<li>- utilize o pacote cnpj_cpf_helper para validar.</li>
<li>- cep: somente 8 números.</li>
<li>- rua: de 3 a 30 caracteres.</li>
<li>- número: somente números.</li>
<li>- bairro: de 3 a 30 caracteres.</li>
<li>- cidade: de 3 a 30 caracteres.</li>
<li>- uf: somente 2 caracteres.</li>
país: aceitar somente Brasil (tanto faz se for caixa baixa ou alta).
Não deixar cadastrar se algum dos campos acima não passarem.
Ao cadastrar apresentar os dados do usuário em um Dialog.
Utilizar uma classe Usuario obrigatoriamente. Ao salvar preencher os atributos da classe conforme os campos em tela.
</h6>
<h5>REQUISITOS DESEJÁVEIS</h5>
<h6>
Todas as validações anteriores.
Quando o email for válido, carregar a imagem do avatar do serviço online Gravatar. Algumas dicas:
<li>Entrar no site https://br.gravatar.com/;
<li>Criar conta;
<li>Confirmar e-mail;
<li>Adicionar imagem;
<li>O endereço https://www.gravatar.com/avatar/[MD5] devolve a imagem.
Para gerar o md5 do email é necessário:
email sem espaços e tudo minusculo.
mesmo email que definiu a imagem no site.
para gerar o md5 utilize o pacote crypto.
Se quiser uma imagem qualquer até que o email seja digitado no campo, pode usar o endereço https://www.gravatar.com/avatar/[RANDOM MD5]?d=robohash.
No campo cpf utilizar o pacote cnpj_cpf_formatter para validar a digitação do usuário com o InputFormatters.
Depois de digitar o cep, utilizar o serviço online ViaCep para consultar o cep e carregar os dados de endereço do usuário. Os campos rua, bairro, cidade e uf são disponibilizados pelo mesmo. Algumas dicas:
Utilize o pacote dio para fazer a requisição.
O site é https://viacep.com.br.
A url para busca é https://viacep.com.br/ws/[CEP]/json/. 
Além da classe Usuario crie outra classe Endereco para seperar os dados de endereço do usuário. Lembrando que Endereco é um atributo do Usuario.
Além do botão Cadastrar , criar um botão Limpar, que limpa todos os campos.
</h6>

<h4>Exercicio realizado em colaboração:</h4>

- [Jessica Prado](https://github.com/jessiigabrielle)

