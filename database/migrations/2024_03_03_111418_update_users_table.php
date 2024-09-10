<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('picture')->after('remember_token');
            $table->string('cover')->after('remember_token');
            $table->text('github')->nullable()->after('remember_token');
            $table->text('intro')->after('remember_token');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('picture');
            $table->dropColumn('cover');
            $table->dropColumn('github');
            $table->dropColumn('intro');
            $table->dropColumn('isadmin');
        });
    }
};
