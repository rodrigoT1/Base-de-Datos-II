create database practica
use practica

create table categorias
(
    category_id integer auto_increment primary key not null,
     nombre varchar (10) not null
)
select *from categorias
create table publisher
(
    publisher integer auto_increment primary key  not null,
    nombre varchar(10) not null
)
select *from publisher
create table book
(
    book_id integer auto_increment primary key not null,
    title varchar(10)not null,
    isb varchar(10) not null,
    published_date date,
    descripcion varchar(10)not null,
    category_id integer not null,
    publisher integer not null,
    foreign key (category_id) references categorias(category_id),
    foreign key (publisher) references publisher(publisher)
)
select *from book