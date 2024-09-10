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
        Schema::create('uva_codes', function (Blueprint $table) {
            $table->id();
            $table->integer('serial');
            $table->text('title');
            $table->text('show');
            $table->text('topic_url');
            $table->integer('star')->nullable();
            $table->text('code')->nullable();
            $table->text('data')->nullable();
            $table->text('data_a')->nullable();
            $table->text('data_b')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('uva_codes');
    }
};
