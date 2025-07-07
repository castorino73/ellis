# Use uma imagem oficial do Python como imagem base.
# python:3.10-slim é uma boa escolha por ser leve.
FROM python:3.10-slim

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
# Fazer isso separadamente aproveita o cache de camadas do Docker.
COPY requirements.txt .

# Instala as dependências.
# --no-cache-dir: Desabilita o cache do pip para manter a imagem menor.
# --upgrade pip: Garante que a versão mais recente do pip seja usada.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta em que a aplicação será executada.
EXPOSE 8000

# Comando para executar a aplicação quando o contêiner iniciar.
# Usamos 0.0.0.0 para que a API seja acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000" , "--reload"]