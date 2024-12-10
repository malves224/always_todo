# Always TODO
Always TODO é um aplicativo de gerenciamento de tarefas que permite aos usuários criar, gerenciar e acompanhar suas listas de afazeres. O aplicativo inclui autenticação de usuários para garantir que os dados de cada usuário estejam seguros e privados. Além disso, possui validações de entrada para manter a integridade dos dados e proporcionar uma experiência de usuário suave.

## SETUP
O projeto possui setup pronto pra rodar localmente com docker-compose:

### Passo a Passo

1. Clone o repositório do projeto:
  ```sh
  git clone https://github.com/malves224/always_todo.git
  cd always_todo
  ```

2. Execute o docker-compose:
  ```sh
  docker-compose up -d
  ```

3. Acesse o frontend no navegador:
  ```
  http://localhost:5173
  ```

## Testes Unitários
O código possui uma cobertura significativa de testes unitários, garantindo a qualidade e a confiabilidade do aplicativo:
![Testes Unitários](../test.png)

## FRONTEND
Repositorio para frontend: https://github.com/malves224/always_todo_front