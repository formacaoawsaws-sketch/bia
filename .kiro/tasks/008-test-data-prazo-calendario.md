# Task 008 - Testes da Funcionalidade Data/Prazo com Calendário

## 🔧 Configuração Inicial (LEIA ANTES DE INICIAR)

### Agent Responsável
**qa** - Este agent deve iniciar a implementação.

### Branch Base
**SEMPRE `ia-main`**

### Worktree
Esta task será implementada em worktree isolado em `.kiro/worktrees/008-test-data-prazo-calendario/`

---

## ⚠️ CHECKLIST DE INÍCIO (OBRIGATÓRIO)

Antes de começar a implementar, o agent deve:

- [ ] **Verificar branch atual:** `git branch --show-current`
  - Se não estiver em `ia-main`, **PERGUNTAR** ao usuário se pode trocar
  - Aguardar autorização
  - Após autorização: `git checkout ia-main && git pull origin ia-main`

- [ ] **Mover task para doing:**
  ```bash
  mv .kiro/tasks/008-test-data-prazo-calendario.md .kiro/tasks/doing/
  git add .kiro/tasks/
  git commit -m "move: task 008 para doing"
  git push origin ia-main
  ```

- [ ] **Criar worktree:**
  ```bash
  git worktree add .kiro/worktrees/008-test-data-prazo-calendario -b test/008-test-data-prazo-calendario ia-main
  cd .kiro/worktrees/008-test-data-prazo-calendario
  git branch --show-current  # Confirmar branch correto: test/008-test-data-prazo-calendario
  ```

---

## 📋 Descrição

Criar testes automatizados para a funcionalidade de **Data/Prazo com Calendário** implementada na task 006. O objetivo é garantir que o componente `AddTask` funcione corretamente com o date picker (`react-datepicker`), cobrindo os fluxos principais de seleção de data, formatação e persistência.

---

## 🎯 Objetivo

Garantir a qualidade e regressão da funcionalidade de calendário, cobrindo:
- Renderização correta do componente
- Seleção de data via calendário
- Formatação da data no padrão brasileiro (dd/mm/yyyy)
- Compatibilidade com o backend (persistência como string)
- Comportamento com datas inválidas ou vazias

---

## 📝 História de Usuário

**Como** desenvolvedor/QA do projeto BIA  
**Quero** ter testes automatizados para o campo Data/Prazo  
**Para que** eu possa garantir que a funcionalidade de calendário continue funcionando corretamente após futuras alterações

---

## ✅ Critérios de Aceitação

1. Testes unitários do componente `AddTask` cobrindo o campo de data
2. Verificação de que o campo exibe o placeholder "Quando?" quando vazio
3. Verificação de que a data selecionada é formatada corretamente (dd/mm/yyyy)
4. Verificação de que a data é enviada como string para o backend
5. Verificação do comportamento com data vazia
6. Todos os testes devem passar (`npm test`)

---

## 🛠️ Implementação

### 1. Análise Prévia

Antes de escrever os testes, o agent deve:

- [ ] Verificar o arquivo `client/src/components/AddTask.jsx` para entender a implementação atual
- [ ] Verificar se já existe algum arquivo de teste para o componente (`AddTask.test.jsx` ou similar)
- [ ] Identificar o framework de testes utilizado no projeto (Jest, Vitest, etc.)
- [ ] Verificar o `client/package.json` para entender as dependências de teste disponíveis

```bash
# Verificar estrutura de testes existente
ls client/src/components/
ls client/src/__tests__/  # Se existir
cat client/package.json | grep -E "(test|jest|vitest)"
```

### 2. Configuração do Ambiente de Testes (se necessário)

Caso não exista um ambiente de testes configurado:

- [ ] Verificar se o projeto usa Vite (e consequentemente Vitest seria a escolha natural)
- [ ] Instalar dependências necessárias:

```bash
cd client
# Para Vitest (recomendado com Vite)
npm install --save-dev vitest @testing-library/react @testing-library/jest-dom @testing-library/user-event jsdom

# OU para Jest (se já configurado)
npm install --save-dev jest @testing-library/react @testing-library/jest-dom @testing-library/user-event
```

- [ ] Configurar o arquivo de setup dos testes (se necessário)
- [ ] Adicionar script de teste no `package.json` se não existir:

```json
"scripts": {
  "test": "vitest",
  "test:run": "vitest run"
}
```

### 3. Criar Arquivo de Testes

**Arquivo a criar:** `client/src/components/AddTask.test.jsx`

#### 3.1 Testes de Renderização

- [ ] **Teste:** Renderiza o componente sem erros
- [ ] **Teste:** Exibe o placeholder "Quando?" no campo de data quando vazio

```javascript
test('deve renderizar o campo de data com placeholder correto', () => {
  // Verificar que o placeholder "Quando?" está visível
});
```

#### 3.2 Testes de Seleção de Data

- [ ] **Teste:** Campo de data aceita uma data válida
- [ ] **Teste:** Data selecionada é exibida no formato dd/mm/yyyy

```javascript
test('deve exibir data no formato dd/mm/yyyy após seleção', async () => {
  // Simular seleção de uma data
  // Verificar que a data é exibida no formato correto
});
```

#### 3.3 Testes de Formatação

- [ ] **Teste:** Conversão de Date para String no padrão pt-BR
- [ ] **Teste:** Data enviada ao backend está no formato string (dd/mm/yyyy)

```javascript
test('deve converter Date para string no formato dd/mm/yyyy', () => {
  // Testar função de formatação de data
});
```

#### 3.4 Testes de Estado Vazio/Nulo

- [ ] **Teste:** Comportamento quando nenhuma data é selecionada
- [ ] **Teste:** Campo pode ser limpo após data selecionada

```javascript
test('deve lidar corretamente com data vazia', () => {
  // Verificar comportamento sem data selecionada
});
```

#### 3.5 Testes de Integração do Formulário

- [ ] **Teste:** Formulário completo pode ser submetido com data selecionada
- [ ] **Teste:** Dados enviados ao backend incluem a data formatada como string

```javascript
test('deve incluir a data na submissão do formulário', async () => {
  // Preencher formulário completo
  // Verificar que a data está nos dados enviados
});
```

### 4. Executar os Testes

- [ ] Executar os testes e verificar se todos passam:

```bash
cd client
npm test
# ou
npm run test:run
```

- [ ] Verificar cobertura de testes (se disponível):

```bash
npm run test -- --coverage
```

### 5. Corrigir Eventuais Falhas

- [ ] Analisar os erros reportados pelos testes
- [ ] Ajustar os testes ou reportar bugs encontrados na funcionalidade
- [ ] Garantir que todos os testes passem antes de finalizar

---

## 🔍 Validações Técnicas

### Componente a Testar
- **Arquivo principal:** `client/src/components/AddTask.jsx`
- **Dependência:** `react-datepicker`
- **Campo de data:** Input com DatePicker (implementado na task 006)

### Comportamentos a Validar
- ✅ Placeholder "Quando?" quando campo vazio
- ✅ Formato dd/mm/yyyy na exibição
- ✅ Tipo string no envio ao backend
- ✅ Compatibilidade com React 18
- ✅ Comportamento com data null/undefined

---

## 📦 Dependências de Teste

```json
{
  "devDependencies": {
    "vitest": "latest",
    "@testing-library/react": "latest",
    "@testing-library/jest-dom": "latest",
    "@testing-library/user-event": "latest",
    "jsdom": "latest"
  }
}
```

> **Nota:** Usar versões compatíveis com React 18 e a versão atual do projeto.

---

## 🔄 Definition of Done (DoD)

- [ ] Análise do componente `AddTask.jsx` realizada
- [ ] Framework de testes identificado e configurado
- [ ] Arquivo `AddTask.test.jsx` criado com todos os casos de teste
- [ ] Testes de renderização implementados e passando
- [ ] Testes de seleção de data implementados e passando
- [ ] Testes de formatação (dd/mm/yyyy) implementados e passando
- [ ] Testes de estado vazio/nulo implementados e passando
- [ ] Testes de submissão do formulário implementados e passando
- [ ] Todos os testes passam com `npm test`
- [ ] Código commitado com mensagens descritivas
- [ ] Push realizado para o branch `test/008-test-data-prazo-calendario`

---

## ⚠️ FINALIZAÇÃO DA TASK (OBRIGATÓRIO)

Quando o agent concluir a implementação:

### 1. Verificação Final
```bash
# Garantir que está no worktree correto
pwd
# Deve estar em: /caminho/do/projeto/.kiro/worktrees/008-test-data-prazo-calendario

# Verificar branch
git branch --show-current
# Deve mostrar: test/008-test-data-prazo-calendario

# Executar testes finais
cd client
npm test
```

### 2. Commit e Push Final
```bash
git add .
git commit -m "test: adiciona testes automatizados para funcionalidade Data/Prazo"
git push -u origin test/008-test-data-prazo-calendario
```

### 3. Voltar para Raiz e Notificar PO
```bash
cd ../../..  # Voltar para raiz do projeto
```

**NOTIFICAR O PO:**
> "Task 008 concluída. Todos os itens do checklist marcados. Branch `test/008-test-data-prazo-calendario` com push realizado. Testes automatizados criados para a funcionalidade Data/Prazo com Calendário. Aguardando revisão do PO para encerramento e abertura de PR."

**⚠️ NÃO REMOVER O WORKTREE. Apenas o PO faz isso após o PR ser mergeado.**

---

## 🎯 ENCERRAMENTO PELO PO (QUANDO NOTIFICADO)

### 1. Revisão
```bash
# Entrar no worktree para revisar
cd .kiro/worktrees/008-test-data-prazo-calendario

# Executar os testes para validar
cd client
npm test

# Verificar se todos os itens do DoD estão ✅
# Revisar o arquivo AddTask.test.jsx
```

### 2. Aprovar e Mover para Done
```bash
# Voltar para raiz
cd ../../..

# Mover task para done
mv .kiro/tasks/doing/008-test-data-prazo-calendario.md .kiro/tasks/done/

# Commit e push no ia-main
git checkout ia-main
git add .kiro/tasks/
git commit -m "move: task 008 para done"
git push origin ia-main
```

### 3. Abrir Pull Request
```bash
# ANTES de abrir PR: confirmar que está no branch da feature
cd .kiro/worktrees/008-test-data-prazo-calendario
git branch --show-current
# Deve mostrar: test/008-test-data-prazo-calendario

# Abrir PR contra ia-main
gh pr create --base ia-main --title "008: Testes da funcionalidade Data/Prazo com Calendário" --body "Closes task 008

## Mudanças
- Criado arquivo AddTask.test.jsx com testes automatizados
- Configurado ambiente de testes (se necessário)
- Cobertura dos principais fluxos da funcionalidade Data/Prazo

## Testes implementados
- ✅ Renderização do componente
- ✅ Placeholder 'Quando?' quando campo vazio
- ✅ Formatação dd/mm/yyyy
- ✅ Conversão Date → String
- ✅ Estado vazio/nulo
- ✅ Submissão do formulário com data"
```

### 4. Após PR Mergeado
```bash
# Voltar para raiz
cd ../../..

# Remover worktree
git worktree remove .kiro/worktrees/008-test-data-prazo-calendario

# Ou com força se necessário:
# git worktree remove --force .kiro/worktrees/008-test-data-prazo-calendario

# Limpar registros
git worktree prune

# (Opcional) Deletar branch local
git branch -d test/008-test-data-prazo-calendario
```

**Notificação:** "Task 008 finalizada. Worktree removido. PR #<número> mergeado com sucesso. Testes da funcionalidade Data/Prazo implementados com sucesso."

---

## 📚 Referências
- [Task 006 - Calendário Data/Prazo](.kiro/tasks/done/006-feat-calendario-data-prazo.md)
- [Worktree Workflow](.kiro/docs/worktree-workflow.md)
- [Worktree Steering](.kiro/docs/worktree-steering.md)
- [Task Template](.kiro/docs/task-template-with-worktree.md)
- [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/)
- [Vitest Docs](https://vitest.dev/)
