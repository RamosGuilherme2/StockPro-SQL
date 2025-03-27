CREATE OR REPLACE FUNCTION VALIDAR_LOGIN(p_username VARCHAR, p_senha VARCHAR)
RETURNS BOOLEAN AS $$
DECLARE
	hash_stored TEXT;
	BEGIN
	
-- Busca o hash armazenado no banco para o usuário fornecido
	SELECT senha INTO hash_stored
	FROM usuarios
	WHERE username = p_username;
	
-- Se nenhum usuário for encontrado, retorne FALSE
	IF hash_stored IS NULL THEN
		RETURN FALSE;
		END IF;
		
-- Valida a senha fornecida com o hash usando 'crypt'
	IF hash_stored = crypt(p_senha, hash_stored) THEN
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;
$$ LANGUAGE plpgsql;


select * from usuarios
