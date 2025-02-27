# Дипломная работа по профессии «Системный администратор» Воронин Владислав

## Задача

Ключевая задача — разработать отказоустойчивую инфраструктуру для сайта, включающую мониторинг, сбор логов и резервное копирование основных данных. Инфраструктура должна размещаться в [Yandex Cloud](https://cloud.yandex.com/) и отвечать минимальным стандартам безопасности: запрещается выкладывать токен от облака в git.

## Примерная схема инфраструктуры

![1731048665922](images/README/1731048665922.png)

## Создание инфраструктуры

Перед началом сформированы ssh ключи:

![1731478219175](images/README/1731478219175.png)

*Инстансы пересоздавались несколько раз, поэтому адреса на скринах могут не совпадать.

*Некоторые файлы типо meta.yaml, terraform.tvars я добавил в gitignor для соблюдения безопасности.

Далее развернут Terraform и с помощью него созданна инфраструктура:

**Провайдер:**

Задаём параметры провайдера для yandex-cloud в [main.tf](terraform/main.tf), объявляем переменные параметров провайдера в [variables.tf](terraform/variables.tf), задаём значения в variables.tfvars и вносим его в gitignore.

**Сеть и группы:**

Созданна основная сеть в [network.tf](terraform/network.tf), две подсети в разных зонах доступности для вм, NAT шлюз и маршрутная таблица, подсеть для балансировщика, подсеть для бастионного хоста. Используем [variables.tf](terraform/variables.tf),  [locals.tf](terraform/locals.tf),  [terraform.tfvars](.gitignore) для реализации цикла for_each при создании подсетей. В этом же файле декларированны целевые группы с нужными планами из задания.

**Виртуальные машины:**

В файле [vms.tf](terraform/vms.tf) декларированны сздаваемые ресурсы. Бастион хост  с внешней сетью и внутренней подъсетью, два вэб сервера в разных зонах доступности только с внутренней сетью, zabbix, elastic, kibana с внешними ip.

**Выводы:**

Прописываем выводы адресов ресурсов в [output.tf](terraform/output.tf)

**Бэкапы:**

В файле [snapshot.tf](terraform/snapshot.tf) настроенна система резервного копирования.

**Проверка и запуск Terraform:**

Инициализируем Terraform `terraform init`. Форматируем код `terraform fmt`, проверяем валидацию кода `terraform validate`, предварительно запускаем планировщик `terraform plan`, делаем `terraform apply --auto-approve` в облако.

![1740656242361](images/README/1740656242361.png)

После развёртования инфраструктуры проверяем установленные инстансы через консоль:

`yc compute instance list`

![1740661384401](images/README/1740661384401.png)

![1740662046679](images/README/1740662046679.png)

![1740662174781](images/README/1740662174781.png)

![1740662188779](images/README/1740662188779.png)

На данном этапе проверяем подключение по ssh через бастион к вм:

![1740662268764](images/README/1740662268764.png)

Проверяем связь ansible с хостами при помощи модуля ping и [hosts.yaml](https://)

![1740665389159](images/README/1740665389159.png)

**Настройка NGINX:**

Создаём [web-playbook.yml](ansible/web-playbook.yml) в role прописываем index.html конфиги и задачи для установки NGINX.

Запускаем его:

`ansible-playbook -i hosts.yml web-playbook.yml --limit webservers`

![1740665929389](images/README/1740665929389.png)

![1740666090766](images/README/1740666090766.png)

**Настройка Elastic:**

Для этого создаём [elast-playbook.yml](ansible/elast-playbook.yml) в ролях прописываем установку docker через `comunity.docker` перед этим установив к себе коллекцию:  `ansible-galaxy collection install community.docker` , так как работа Elastic реалезованна через docker container.

Настройка Kibana:

Так же запускаеь через контейнер с помощью [kibana-playbook.yml](ansible/kibana-playbook.yml) и соответствующих ролей

![1740674856569](images/README/1740674856569.png)

Установка [Filebeat ](ansible/filebeat-playbook.yml)на вэб сервера. В конфигу настраиваем отправку логов nginx в Elasticsearch.

Настройка Zabbix:

Настраиваем и конфигурируем zabbix запускаем [zabbix_server-playbook.yml](ansible/zabbix_server-playbook.yml)

![1740675512079](images/README/1740675512079.png)

Далее устанавливаем агента на все ВМ, для этого запустим [zabbix_agent-playbook.yml](ansible/zabbix_agent-playbook.yml)

![1740676042793](images/README/1740676042793.png)

![1740676061049](images/README/1740676061049.png)

![1740678834435](images/README/1740678834435.png)

![1740679093374](images/README/1740679093374.png)
