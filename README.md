### users テーブル

| Column               | Type    | Options                   |
|----------------------|---------|---------------------------|
| nickname             | string  | null: false               |
| email                | string  | null: false, unique: true |
| encrypted_password   | string  | null: false               |
| last_name            | string  | null: false               |
| first_name           | string  | null: false               |
| last_name_kana       | string  | null: false               |
| first_name_kana      | string  | null: false               |
| birth_date           | date    | null: false               |
| customer_id          | string  | unique: true              |

# Association

•	has_many :items
•	has_many :orders


### items テーブル

| Column               | Type       | Options                        |
|----------------------|------------|--------------------------------|
| name                 | string     | null: false                    |
| price                | integer    | null: false                    |
| category             | string     | null: false                    |
| image                | string     |                                |
| shopping_area        | string     | null: false                    |
| condition            | string     | null: false                    |
| stock_status         | string     | null: false                    |
| shopping_fee_status  | string     | null: false                    |
| shopping_days        | string     | null: false                    |
| user                 | references | null: false, foreign_key: true |

# Association

•	belongs_to :user
•	has_many :orders


### orders テーブル

| Column               | Type       | Options                        |
|----------------------|------------|------------------------------- |
| charge_id            | string     |                                |
| user                 | references | null: false, foreign_key: true |
| item                 | references | null: false, foreign_key: true |
| total_price          | integer    |                                |
| prefecture           | integer    | null: false                    |
| city                 | string     | null: false                    |
| address_line1        | string     | null: false                    |
| address_line2        | string     |                                |
| phone_number         | string     | null: false                    |

# Association
•	belongs_to :user
•	belongs_to :item