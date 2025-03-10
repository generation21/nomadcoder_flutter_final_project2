"""Add board model

Revision ID: fe6beed920bf
Revises: 495efe7e256e
Create Date: 2025-03-08 19:31:52.578319

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'fe6beed920bf'
down_revision = '495efe7e256e'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('users', sa.Column('owner_id', sa.String(), nullable=True))
    op.create_foreign_key(None, 'users', 'users', ['owner_id'], ['firebase_uid'])
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'users', type_='foreignkey')
    op.drop_column('users', 'owner_id')
    # ### end Alembic commands ### 