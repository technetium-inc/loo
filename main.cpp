#include <iostream>
#include <vector>

struct TokenData {
    std::string token_data;
    std::string token_type;
};

class Token {
    public:
    std::string token_data;
    std::string token_type;

    Token(std::string token_data, std::string token_type){
        this->token_data = token_data;
        this->token_type = token_type;
    }

    TokenData get() {
        TokenData token;
        token.token_data = this->token_data;
        token.token_type = this->token_type;

        return (token);
    }

};
