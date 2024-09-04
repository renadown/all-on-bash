#!/bin/bash

# Função para checar erros e parar o script se um comando falhar
check_error() {
  if [ $? -ne 0 ]; then
    echo "Erro: $1"
    exit 1
  fi
}

# Obtém o hostname do sistema usando o comando hostnamectl
hostname=$(hostnamectl --static)
echo "Hostname detectado: $hostname"

# Pergunta ao usuário o valor de HostMetadata
read -p "Insira o valor para HostMetadata (por exemplo, 'Localidade=SAL-01'): " host_metadata

# Verifica se o Zabbix Agent já está instalado
if yum list installed | grep -q "zabbix-agent"; then
    echo "Zabbix Agent já está instalado."
    exit 1
fi

# Instala o Zabbix Agent
echo "Instalando o Zabbix Agent..."
yum install -y zabbix-agent
check_error "Falha na instalação do Zabbix Agent."

# Configura o Zabbix Agent
echo "Configurando o Zabbix Agent..."
sed -i "s/^Hostname=.*/Hostname=${hostname}/" /etc/zabbix/zabbix_agentd.conf
check_error "Falha ao configurar Hostname."

sed -i "s/^HostMetadata=.*/HostMetadata=${host_metadata}/" /etc/zabbix/zabbix_agentd.conf
check_error "Falha ao configurar HostMetadata."

# Reinicia o serviço do Zabbix Agent
echo "Reiniciando o serviço Zabbix Agent..."
systemctl restart zabbix-agent
check_error "Falha ao reiniciar o serviço Zabbix Agent."

# Verifica se a porta 10050 está aberta
echo "Verificando se a porta 10050 está aberta..."
if netstat -lntp | grep -q ":10050"; then
    echo "Zabbix Agent está em execução na porta 10050."
else
    echo "Erro: Zabbix Agent não está escutando na porta 10050."
    exit 1
fi

echo "Instalação e configuração do Zabbix Agent concluídas com sucesso."
