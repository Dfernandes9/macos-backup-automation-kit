---
name: aero-recovery-organizer
description: Find, assess, classify, stage, and safely organize recovered files and candidate WhatsApp, iPhone/iPad, and Mac backups. Use when inspecting recovery folders, deduplicating recovered material, or assessing backup restoration options.
---

# AERO Recovery Organizer

Use this skill to inventory and assess recovery material, prepare a reversible organization plan, and carry out only clearly classified, non-destructive file organization. It does not claim access to devices, cloud accounts, disks, or backups unless a connected tool actually provides that access.

## Objetivo

Localizar materiais de recuperação em áreas autorizadas, identificar o que cada item contém e se é utilizável, integrá-lo à pasta de destino adequada, reduzir nomes genéricos de recuperação e consolidar pastas relacionadas sem perder dados, contexto ou proveniência.

A skill deve reconhecer, entre outros, diretórios e arquivos com nomes como `Recovered`, `Recovery`, `Recovered Files`, `Disk Drill`, `Wondershare`, `Data Recovery`, `WhatsApp`, `iPhone`, `iOS Backup`, `iTunes`, `Finder Backup`, `Time Machine` e equivalentes em português. Nome é apenas pista: classificar pelo conteúdo e metadados disponíveis, nunca pelo nome isolado.

## Resultado esperado

Ao final de cada execução, entregar:

1. Inventário das pastas e arquivos encontrados, com caminho original, tamanho, datas e tipo provável.
2. Classificação do material: recuperado, duplicado, incompleto, ilegível, vazio, backup ou não identificado.
3. Avaliação de integridade e viabilidade, indicando o que foi verificado e o que não foi possível verificar.
4. Ações realizadas, caminhos de origem e destino, itens ignorados e motivo.
5. Alertas de backups potencialmente restauráveis de WhatsApp, iPhone/iPad ou Mac, com dispositivo/conta compatível, data e limitações conhecidas.
6. Lista de decisões que dependem de confirmação, sem apresentar possibilidade como restauração concluída.

## Escopo e pré-condições

- Examinar apenas unidades, contas, diretórios e aplicativos aos quais a sessão atual tenha acesso autorizado. Não contornar senha, criptografia, bloqueio de dispositivo, permissões do sistema ou proteção de conta.
- Antes de alterações, confirmar que a localização de destino tem espaço suficiente e que os arquivos podem ser lidos. Se a área estiver sincronizada com nuvem, considerar que mover ou apagar pode replicar a alteração em outros dispositivos.
- Não tratar miniaturas, nomes de arquivos, extensões ou resultados de busca como prova de conteúdo íntegro.
- Não abrir nem executar aplicativos, scripts, instaladores, macros ou arquivos suspeitos recuperados. Analisar por metadados e ferramentas de leitura seguras.
- Se a conexão ou permissão necessária não estiver disponível, registrar a limitação e fornecer caminhos/instruções concretos; nunca afirmar que examinou conteúdo inacessível.

## Fluxo de trabalho

### 1. Descoberta e inventário

- Procurar pastas candidatas pelos nomes conhecidos e por padrões como diretórios recentemente criados, lotes de arquivos sem categoria ou pastas com estrutura típica de software de recuperação.
- Percorrer recursivamente as pastas candidatas, incluindo itens ocultos somente quando o acesso autorizado permitir e isso for relevante para a recuperação.
- Criar um manifesto antes de modificar qualquer coisa: caminho, nome, tipo/MIME, tamanho, datas disponíveis, hash criptográfico quando viável e relação com a pasta-pai.
- Detectar links simbólicos, aliases, arquivos online sob demanda, volumes desconectados e erros de leitura; não segui-los para fora do escopo sem autorização.

### 2. Triagem e viabilidade

- Agrupar por tipo de conteúdo, projeto, pessoa, dispositivo ou aplicativo; usar conteúdo e metadados disponíveis e preservar hierarquias úteis.
- Identificar duplicatas exatas por hash. Marcar possíveis duplicatas por nome/tamanho como não confirmadas até comparar conteúdo.
- Para arquivos incompletos ou ilegíveis, tentar leitura não destrutiva e registrar erros. Não reparar, converter ou sobrescrever o único exemplar.
- Marcar pastas vazias e pastas compostas apenas por duplicatas; verificar também se contêm metadados, logs, bancos de dados ou arquivos ocultos antes de considerá-las vazias.
- A classificação deve distinguir “backup encontrado”, “backup estruturalmente reconhecido” e “restauração compatível confirmada”. Não prometer recuperação de dados apagados sem evidência técnica.

### 3. Plano de organização

- Escolher destino pela pertinência do conteúdo e pela organização existente. Reutilizar pastas existentes quando forem claramente correspondentes; evitar criar categorias paralelas.
- Se a pasta tiver nome genérico de recuperação, propor um nome descritivo a partir do conteúdo, por exemplo `Fotos recuperadas — iPhone — AAAA-MM`, `WhatsApp — backup recuperado — AAAA-MM-DD` ou `Documentos recuperados — projeto`. Não inferir pessoa, dispositivo ou data sem evidência.
- Se o destino estiver ambíguo, manter em uma pasta de triagem com nome neutro e incluir a dúvida no relatório.
- Preparar um plano com origem, destino, renomeações, deduplicações e conflitos antes das mudanças em lote.

### 4. Integração e consolidação

- Mover/consolidar somente itens cuja categoria e destino sejam claros. Preservar a estrutura interna necessária para que bancos, bibliotecas, pacotes e backups continuem utilizáveis.
- Ao unir pastas, comparar colisões: hash igual = duplicata exata; hash diferente = conflito, manter ambos com nomes distintos e registrar a origem. Nunca substituir silenciosamente.
- Validar a cópia/movimentação por contagem, tamanho e hash quando disponível. Manter um registro de caminho de origem → destino e a data da ação.
- Só retirar um nome genérico depois de confirmar a classificação e concluir a integração. Se renomear quebrar uma estrutura esperada por um aplicativo, manter o nome original ou criar uma pasta externa descritiva sem alterar a estrutura interna.
- Não apagar conteúdo recuperado. Uma cópia duplicada só pode ser removida depois de comparação por hash, validação da cópia preservada e existência de registro recuperável da ação. Se não houver mecanismo confiável de reversão, manter as duas e reportar.
- Pastas vazias podem ser incorporadas à estrutura final; excluir a pasta de origem apenas após verificar que ela está realmente vazia e que a ação é reversível ou explicitamente autorizada. Nunca apagar volumes, backups inteiros, lixeiras ou diretórios do sistema como parte da organização.

### 5. Backups e restauração

Procurar estruturas compatíveis com backups de WhatsApp, iPhone/iPad (Finder/iTunes/iCloud, quando acessível) e Mac (Time Machine e outros formatos identificáveis). Para cada possível backup, informar:

- Tipo e aplicativo provável, localização, data/tamanho e estado de leitura.
- Se parece completo, criptografado, incompleto ou ainda não validado.
- Compatibilidade conhecida e pré-requisitos, sem expor senhas nem tentar quebrar criptografia.
- Risco de substituir dados atuais, versão do sistema necessária e opções menos arriscadas, como extrair para uma cópia ou restaurar em dispositivo separado.

**Não iniciar uma restauração que substitua estado de aparelho, conta ou backup atual sem confirmação explícita para aquele backup e aquele destino.** Antes de restaurar, criar ou confirmar uma cópia de segurança do estado atual, registrar o que será substituído e validar que existe espaço e compatibilidade. Preferir exportar/recuperar para uma pasta de trabalho ou dispositivo de teste quando o método suportar isso. Não misturar bancos de dados de WhatsApp de origens distintas nem restaurar banco de dados isolado sem os arquivos associados.

Se a sessão não tiver ferramenta ou permissão para restaurar, avisar que o backup foi identificado e preparar instruções precisas para o usuário executar no aplicativo/dispositivo apropriado. Após uma restauração autorizada, verificar o resultado e tornar os arquivos exportados disponíveis na pasta pertinente, conservando o backup de origem.

### 6. Fechamento e relatório

Usar estados claros: `encontrado`, `classificado`, `candidato viável`, `restauração aguardando confirmação`, `integrado`, `não foi possível validar` ou `erro`. Separar fatos observados de inferências. Informar totais e caminhos; não declarar sucesso quando houve apenas cópia parcial, leitura parcial ou análise de nomes.

## Integração com o repositório de automação de backups

Esta skill é uma camada independente de inventário, triagem e organização. Não executar automaticamente `run_backup.sh`, `icloud_consolidate.sh` ou `time_machine_backup.sh` durante uma tarefa de recuperação: esses scripts pertencem ao fluxo de criação/consolidação de backups e podem alterar destinos ou dados. A execução deles requer uma tarefa de backup separada, revisão da configuração e autorização explícita para o destino.

## Limites de segurança e reversão

- A fonte original é a evidência de recuperação: preservar uma cópia imutável antes de qualquer reparo, conversão, deduplicação destrutiva ou restauração.
- Não formatar, inicializar, particionar, reparar filesystem, executar `fsck`/equivalentes com escrita, limpar lixeira, remover backups ou esvaziar pastas de recuperação automaticamente.
- Não sobrescrever backups, arquivos atuais, bancos de dados ou pastas de destino. Em qualquer colisão não resolvida, parar aquela operação, preservar ambos e reportar.
- Parar e reportar se o meio apresentar falha física, ruído, desconexões ou erros crescentes de leitura; novas tentativas podem piorar a recuperação. Recomendar imagem/clonagem especializada antes de continuar.
- Toda alteração deve ser auditável e reversível sempre que tecnicamente possível. Registrar a operação antes/depois e validar o destino.

## Modelo de relatório

```text
Resumo: [resultado em uma frase]
Escopo examinado: [locais acessíveis]
Encontrado: [N pastas, N arquivos, tamanho aproximado]
Viabilidade: [confirmada / parcial / não determinada]
Backups detectados: [tipo, data, localização, status]
Organização: [origem → destino; renomes e consolidações]
Duplicatas/conflitos: [hash comparado; resolução]
Ações pendentes: [confirmação necessária e impacto]
Limitações/erros: [o que não foi acessível ou validado]
Integridade: [manifesto, hashes e validações realizadas]
```

## Critérios de conclusão

A execução termina quando todas as pastas candidatas acessíveis foram inventariadas; cada item relevante foi classificado ou marcado como incerto; o material claro foi integrado com validação e proveniência; candidatos a backup foram reportados com viabilidade e risco; e nenhum conflito, restauração ou apagamento foi tratado como concluído sem as salvaguardas acima.
