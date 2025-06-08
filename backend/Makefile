# Nome do ambiente Conda
CONDA_ENV=web

# Caminho para o diretório do app
PYTHONPATH=./

# Roda um comando dentro do ambiente Conda
define run_in_conda
	conda run -n $(CONDA_ENV) $(1)
endef

# Instala as dependências do projeto (requirements.txt e requirements-dev.txt)
install:
	$(call run_in_conda,pip install -r requirements.txt)
	$(call run_in_conda,pip install -r requirements-dev.txt)

# Roda os testes com pytest, garantindo o PYTHONPATH correto
test:
	PYTHONPATH=$(PYTHONPATH) $(call run_in_conda,pytest)

# Executa o backend com reload
run:
	$(call run_in_conda,uvicorn app.main:app --reload)

# Remove os arquivos de cache e bytecode (sem remover o ambiente)
clean:
	find . -type d -name "__pycache__" -exec rm -r {} +
	find . -name "*.pyc" -delete
