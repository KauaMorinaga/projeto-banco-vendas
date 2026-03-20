USE VENDAS;

create table CLIENTES(
id_cliente int NOT NULL auto_increment,
nome VARCHAR (30) NOT NULL,
cpf_cnpj varchar (14) NOT NULL,
email varchar (60) UNIQUE,
telefone VARCHAR (15) UNIQUE,
data_de_cadastro date not null,

primary key (id_cliente),
UNIQUE (cpf_cnpj)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


INSERT INTO CLIENTES(nome,cpf_cnpj,email,telefone,data_de_cadastro)
values
('Roberto','12345678900','joao@email.com','11987654321','2026-03-16'),
('Maria Das Flores','98765432100','maria@email.com','11999998888','2026-03-16');

select * from ITENS_PEDIDO;

create table CATEGORIA(
id_categoria int not null auto_increment,
nome varchar (30) not null unique,

primary key ( id_categoria)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;


create table PRODUTOS(
id_produto int not null auto_increment,
nome varchar (30) not null,
descricao varchar (250) not null,
preco decimal (10,2) not null,
estoque int not null,
id_categoria int not null,

primary key (id_produto),
foreign key (id_categoria)
references CATEGORIA(id_categoria)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;



create table PEDIDOS(
id_pedido int not null auto_increment,
id_cliente int not null,
data_pedido date  not null,
status enum ('Pendente','Pago','Enviado', 'Cancelado'),

primary key (id_pedido),
foreign key (id_cliente)
references CLIENTES (id_cliente)
)engine = InnoDB default charset=utf8mb3;


create table Itens_Pedido(
id_item int not null auto_increment,
id_pedido int not null,
id_produto int not null,
quantidade int not null,
preco_do_produto decimal (10,2) not null,

primary key ( id_item),
foreign key(id_pedido)
references PEDIDOS (id_pedido),
foreign key (id_produto)
references PRODUTOS (id_produto)
) engine = InnoDB default charset = utf8mb3;


insert into  CATEGORIA (nome)
VALUES 
('Infanti'),
('Adulto'),
('Esportivo'),
('Acessorios'),
('Tecnologia');


INSERT INTO PRODUTOS ( nome,descricao,preco,estoque, id_categoria)
values 
('Camiseta Infantil','Camiseta infantil de algodao',39.90,50,1),
('Tenis Infantil','Tenis infantil confortavel',129.90,20,1),
('Calca Jeans','Calca jeans masculina azul',119.90,30,2),
('Camisa Social','Camisa social manga longa',99.90,25,2),
('Bola de Futebol','Bola oficial para futebol campo',59.90,40,3),
('Luva de Academia','Luva esportiva para treino',49.90,15,3),
('Bone','Bone ajustavel esportivo',29.90,35,4),
('Mochila','Mochila casual resistente',89.90,18,4),
('Mouse Gamer','Mouse gamer com led',149.90,12,5),
('Teclado Mecanico','Teclado mecanico gamer',299.90,10,5);


INSERT INTO CLIENTES (nome , cpf_cnpj,email,telefone,data_de_cadastro)
values
('Carlos Silva','11122233344','carlos1@email.com','11988887771','2026-03-10'),
('Ana Pereira','22233344455','ana1@email.com','11977776661','2026-03-11'),
('Joao Santos','33344455566','joao1@email.com','11966665551','2026-03-12'),
('Fernanda Lima','44455566677','fernanda1@email.com','11955554441','2026-03-13'),
('Lucas Oliveira','55566677788','lucas1@email.com','11944443331','2026-03-14'),
('Juliana Costa','66677788899','juliana1@email.com','11933332221','2026-03-15'),
('Pedro Almeida','77788899900','pedro1@email.com','11922221112','2026-03-16'),
('Mariana Rocha','88899900011','mariana1@email.com','11911112223','2026-03-17'),
('Rafael Martins','99900011122','rafael1@email.com','11912345679','2026-03-18'),
('Camila Barros','12312312399','camila1@email.com','11987651235','2026-03-19');



INSERT INTO PEDIDOS (id_cliente, data_pedido , status)
VALUES 	
(1,'2026-03-20','Pago'),
(2,'2026-03-20','Enviado'),
(13,'2026-03-21','Pendente'),
(14,'2026-03-21','Pago'),
(15,'2026-03-22','Cancelado'),
(16,'2026-03-22','Pago'),
(17,'2026-03-23','Enviado'),
(18,'2026-03-23','Pago'),
(19,'2026-03-24','Pendente'),
(20,'2026-03-24','Pago'),
(21,'2026-03-25','Enviado'),
(22,'2026-03-25','Pago');



INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_do_produto)
VALUES (46,1,1,39.90);

INSERT INTO Itens_Pedido (id_pedido, id_produto, quantidade, preco_do_produto)
VALUES (47,9,1,149.90),
(48,5,2,59.90),
(49,3,1,119.90),
(50,2,1,129.90),
(51,7,3,29.90),
(52,6,1,49.90),
(53,10,1,299.90),
(54,4,2,99.90),
(55,8,1,89.90),
(56,5,1,59.90),
(57,9,2,149.90);

#MAIS VENDIDOS

select 
PRODUTOS.nome,
SUM(Itens_Pedido.quantidade)
from Itens_Pedido
join PRODUTOS 
ON Itens_Pedido.id_produto = PRODUTOS.id_produto 
group by  PRODUTOS.nome
ORDER BY SUM(Itens_Pedido.quantidade) DESC;

#FATURAMENTO POR CLIENTE

select
CLIENTES.nome,
sum(Itens_Pedido.quantidade * Itens_Pedido.preco_do_produto)
FROM Itens_Pedido
JOIN PEDIDOS
ON Itens_Pedido.id_pedido = PEDIDOS.id_pedido
JOIN CLIENTES 
ON PEDIDOS.id_cliente = CLIENTES.id_cliente
group by CLIENTES.nome
order by sum(Itens_Pedido.quantidade * Itens_Pedido.preco_do_produto) DESC;


#FATURAMENTO POR PRODUTO

select
PRODUTOS.nome,
sum(Itens_Pedido.quantidade * Itens_Pedido.preco_do_produto)
from Itens_Pedido 
join PRODUTOS
On Itens_Pedido.id_produto = PRODUTOS.id_produto
group by PRODUTOS.nome
order by sum(Itens_Pedido.quantidade * Itens_Pedido.preco_do_produto) DESC;
