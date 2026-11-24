reset_db() {
    local USER_PASS

    printf "Пароль kasobko: " && read -s USER_PASS && echo

    sudo mariadb -e "
        DROP DATABASE IF EXISTS campus_web;
        DROP USER IF EXISTS 'kasobko'@'localhost';
    " && \
    sudo mariadb < t00_database_and_user/db.sql && \
    mariadb -u kasobko -p"$USER_PASS" campus_web < t01_table_and_data/table.sql && \
    mariadb -u kasobko -p"$USER_PASS" campus_web < t01_table_and_data/data.sql && \
    mariadb -u kasobko -p"$USER_PASS" campus_web < t02_more_tables/extended.sql && \
    mariadb -u kasobko -p"$USER_PASS" campus_web < t02_more_tables/data.sql && \
    echo "Базу успішно перестворено. Результат find.sql:" && \
    mariadb -u kasobko -p"$USER_PASS" campus_web < t05_find_out_the_truth/find.sql
}
