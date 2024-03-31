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
        Schema::create('uva_topics', function (Blueprint $table) {
            $table->id();
            $table->integer('serial');
            $table->text('title');
            $table->text('show');
            $table->text('topic_url');
            $table->integer('star')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('uva_topics');
    }
};
