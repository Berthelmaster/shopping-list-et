using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace shopping_list_et.infrastructure.Migrations
{
    public partial class Intial2 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<DateTime>(
                name: "UpdatedAt",
                table: "ShoppingLists",
                type: "datetime2",
                nullable: true);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "UpdatedAt",
                table: "ShoppingLists");
        }
    }
}
