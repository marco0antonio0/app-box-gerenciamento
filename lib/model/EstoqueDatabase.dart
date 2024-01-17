// ignore_for_file: file_names

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ===========================================================
//              Class de padrão Singleton
class EstoqueDatabase {
  // Singleton instance
  static EstoqueDatabase? _instance;

  // Private constructor to prevent multiple instances
  EstoqueDatabase._privateConstructor();

  // Database instance
  static Database? _database;

  // Singleton getter
  static EstoqueDatabase get instance {
    _instance ??= EstoqueDatabase._privateConstructor();
    return _instance!;
  }

  // Função geter
  // Função verifica se o banco de dados exista
  // Caso exita ele retorna o mesmo
  // Caso NÃO exita ele iniciara outro database
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _init();
    return _database;
  }

  // Função recal para iniciar o banco de dados
  Future<Database> _init() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'estoque_data3.db'),
      onCreate: (db, version) {
        // =========================================================
        //                QUERY DATABASE ESTOQUE
        db.execute(
          '''
            CREATE TABLE estoque (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              pathImage TEXT,
              nomeProd TEXT,
              descProd TEXT,
              valorProd TEXT,
              qtdsProd TEXT,
              dataCriacao TEXT,
              dataAlteracao TEXT
            )
            ''',
        );
        // =========================================================
        //                QUERY DATABASE USUARIOS
        db.execute(
          '''
            CREATE TABLE usuarios (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              nome TEXT
            )
            ''',
        );
      },
      version: 5,
    );
  }

// ==================================================================================
//                FUNÇÕES CRUD DO DATABASE - USUARIO - ESTOQUE
// ==================================================================================
// ==================================================================================

  // Function to execute raw SQL query
  Future<List<Map<String, dynamic>>> rawQuery(String sql,
      [List<dynamic>? arguments]) async {
    var db = await EstoqueDatabase.instance.database;
    return await db!.rawQuery(sql, arguments);
  }

  // Função para cadastrar um produto
  Future<void> insertProduct({
    required String nomeProd,
    required String pathImage,
    required String descProd,
    required String valorProd,
    required String qtdsProd,
    required String dataCriacao,
    required String dataAlteracao,
  }) async {
    var db = await EstoqueDatabase.instance.database;
    await db!.rawInsert(
      '''
      INSERT INTO estoque (
        nomeProd,pathImage, descProd, valorProd, qtdsProd, dataCriacao, dataAlteracao
      ) VALUES (?,?, ?, ?, ?, ?, ?)
      ''',
      [
        nomeProd,
        pathImage,
        descProd,
        valorProd,
        qtdsProd,
        dataCriacao,
        dataAlteracao
      ],
    );
  }

  // Função para resgatar todos os produto
  Future<List<Map<String, dynamic>>> getAllProducts() async {
    var db = await EstoqueDatabase.instance.database;
    return await db!.rawQuery('SELECT * FROM estoque');
  }

  // Função para atualizar um produto especifico
  Future<void> updateProduct({
    required int id,
    required String nomeProd,
    required String pathImage,
    required String descProd,
    required String valorProd,
    required String qtdsProd,
    required String dataAlteracao,
  }) async {
    var db = await EstoqueDatabase.instance.database;
    await db!.rawUpdate(
      '''
      UPDATE estoque SET
        nomeProd = ?,
        pathImage = ?,
        descProd = ?,
        valorProd = ?,
        qtdsProd = ?,
        dataAlteracao = ?
      WHERE id = ?
      ''',
      [nomeProd, pathImage, descProd, valorProd, qtdsProd, dataAlteracao, id],
    );
  }

  // Função para deletar um produto especifico
  Future<void> deleteProduct(int id) async {
    var db = await EstoqueDatabase.instance.database;
    await db!.rawDelete('DELETE FROM estoque WHERE id = ?', [id]);
  }

  // Função para contar o número de produtos
  Future<int> countProducts() async {
    var db = await EstoqueDatabase.instance.database;
    var result = await db!.rawQuery('SELECT COUNT(*) FROM estoque');
    var count = Sqflite.firstIntValue(result);
    return count ?? 0;
  }

  // Função para cadastrar um novo usuário
  Future<void> cadastrarUsuario(String nome) async {
    var db = await EstoqueDatabase.instance.database;
    await db!.rawInsert(
      '''
      INSERT INTO usuarios (nome) VALUES (?)
      ''',
      [nome],
    );
  }

  // Função para atualizar os dados de um usuário
  Future<void> atualizarUsuario({nome, nomeID}) async {
    var db = await EstoqueDatabase.instance.database;
    await db!.rawUpdate(
      '''
      UPDATE usuarios SET nome = ? WHERE nome = ?
      ''',
      [nome, nomeID],
    );
  }

  // Função para resgatar todos os usuários
  Future<List<Map<String, dynamic>>> getAllUsuarios() async {
    var db = await EstoqueDatabase.instance.database;
    return await db!.rawQuery('SELECT * FROM usuarios');
  }

  // Função para deletar todos os produtos
  Future<void> deleteAllProducts() async {
    var db = await EstoqueDatabase.instance.database;
    await db!.rawDelete('DELETE FROM estoque');
  }
}
